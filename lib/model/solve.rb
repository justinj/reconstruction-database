module ReconDatabase 
  Sequel.extension :blank
  class Solve < Sequel::Model
    include FormattingUtils

    many_to_one :average

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

    def tag(tag_name)
      t = Tag.find_or_create(name: tag_name)
      add_tag(t)
    end

    def before_save
      self.date_added ||= Time.now
      super
    end

    class << self
      def request(params)
        fields.inject(joined) do |result, field|
          field.filter_solves(result, params)
        end
      end

      # need to ask someone how to do this properly
      def joined
        Solve.join(Average.select(:solver_id, :puzzle_id, :competition_id, Sequel.as(:id, :average_id)), average_id: :average_id)
      end

      def fields
        [Solver, Competition, Puzzle, SolveTime]
      end
    end
  end
end
