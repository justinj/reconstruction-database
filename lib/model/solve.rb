require "set"
require "pry"

module RCDB 
  Sequel.extension :blank
  class Solve < Sequel::Model
    extend Forwardable
    
    include FormattingUtils
    include Taggable

    def_delegators :average, :solver, :competition, :puzzle

    many_to_many :tags

    many_to_one :average
    many_to_one :reconstructor

    one_to_many :steps
    one_to_many :stat_sections

    def stats=(sections)
      sections.each.with_index do |section, position|
        add_stat_section(StatSection.create_from_post_data(section, position))
      end
    end

    def before_destroy
      stat_sections.each(&:destroy)
    end

    # when editing the stats the format is different than when parsing brest
    # stuff
    def edited_stats=(value)
      by_id = {}
      stat_sections.each do |section|
        by_id[section.id] = section
      end
      sorted_sections = value.split("&section[]=").drop(1)
      sorted_sections.map! { |res| by_id[res.to_i] }
      sorted_sections.each.with_index { |section, i| section.position = i }
      sorted_sections.map(&:save)
      unused_sections = stat_sections - sorted_sections
      unused_sections.each { |s| s.destroy }
    end

    def puzzle
      average ? average.puzzle : Puzzle.default
    end

    def position_in_average
      super || 0
    end

    def view
      (puzzle.formatting_type+"_solution").to_sym
    end

    def solution
      steps.sort_by(&:position_in_solve).map do |step|
        "#{step.moves} #{puzzle.delimiter} #{step.explanation}"
      end.join("\n")
    end

    def solution=(value)
      save
      remove_all_steps
      extract_steps(value).each do |step|
        step = Step.new(step)
        add_step(step)
      end
    end

    def reconstructor=(value)
      super(Reconstructor.find_or_create(name: value.chomp))
    end

    def effective_value
      if plus_two?
        (time + 2).to_f
      else
        time.to_f
      end
    end

    def has_time?
      time != 0 && !time.blank?
    end

    def dnf?
      penalty == "dnf"
    end

    def plus_two?
      penalty == "+2"
    end

    def visible?
      steps.any? { |step| !step.blank? }
    end

    def format
      if !has_time?
        "#{movecount} HTM"
      elsif dnf?
        "DNF(#{format_time(effective_value)})"
      elsif plus_two?
        "#{format_time(effective_value)}+"
      else
        format_time(effective_value)
      end
    end

    def movecount
      canonical_solution.gsub(%r(//.*?$), "").split(/\s+/).count
    end

    def canonical_solution
      sup = super
      sup.blank? ? solution : sup
    end

    def all_tags
      average.tags + tags
    end

    def before_save
      self.date_added ||= Time.now
      super
    end

    private

    def extract_steps(solution)
      solution.lines.each_with_index.map do |line, i|
        moves, explanation = line.chomp.split(%r$\s*#{puzzle.delimiter}\s+$)
        {moves: moves,
          explanation: explanation,
          position_in_solve: i}
      end
    end

    class << self
      def request(params)
        fields.inject(joined) do |result, field|
          field.filter_solves(result, params)
        end
      end

      # need to ask someone how to do this properly
      # <cringe>
      # paying for my past mistakes
      def joined
        Solve.join(
          Average.select(
            :id___average_id,
            :puzzle_id,
            :solver_id,
            :competition_id,
            :visible
          ),
          average_id: :average_id)
          .join(
            Puzzle.select(
              Sequel.as(:name, :puzzle_name),
              Sequel.as(:id, :puz_id),
            ),
            puz_id: :puzzle_id
          )
          .join(
            Solver.select(
              Sequel.as(:name, :solver_name),
              Sequel.as(:id, :solver_id_selected),
            ),
            solver_id_selected: :t1__solver_id
          )
          .join(
            Competition.select(
              Sequel.as(:name, :competition_name),
              Sequel.as(:id, :comp_id),
            ),
            comp_id: :t1__competition_id
          )
          .join(
            Reconstructor.select(
              Sequel.as(:name, :reconstructor_name),
              Sequel.as(:id, :recon_id),
            ),
            recon_id: :solves__reconstructor_id
          )
      end

      def fields
        [Solver, Competition, Puzzle, SolveTime, Tag, Reconstructor]
      end
    end
  end
end
