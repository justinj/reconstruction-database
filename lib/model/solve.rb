module RCDB 
  Sequel.extension :blank
  class Solve < Sequel::Model
    include FormattingUtils
    include Taggable

    many_to_one :average
    one_to_many :steps
    many_to_many :tags

    def puzzle
      average.puzzle
    end

    def competition
      average.competition
    end

    def solver
      average.solver
    end

    def solution
      steps.sort_by(&:position_in_solve).map do |step|
        "#{step.moves} // #{step.explanation}"
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

    def effective_value
      if plus_two?
        (time + 2).to_f
      else
        time.to_f
      end
    end

    def dnf?
      penalty == "dnf"
    end

    def plus_two?
      penalty == "+2"
    end

    def format
      if dnf?
        "DNF(#{format_time(effective_value)})"
      elsif plus_two?
        "#{format_time(effective_value)}+"
      else
        format_time(effective_value)
      end
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
        moves, explanation = line.chomp.split(%r$\s*//\s*$)
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
      def joined
        Solve.join(Average.select(:solver_id, :puzzle_id, :competition_id, Sequel.as(:id, :avg_id)), avg_id: :average_id)
      end

      def fields
        [Solver, Competition, Puzzle, SolveTime, Tag]
      end
    end
  end
end
