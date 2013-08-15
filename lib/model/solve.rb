module ReconDatabase 
  Sequel.extension :blank
  class Solve < Sequel::Model
    include FormattingUtils

    many_to_one :average
    many_to_one :competition
    many_to_one :solver
    many_to_one :puzzle

    def effective_value
      if plus_two?
        time + 2
      else
        time
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

    def before_save
      self.date_added ||= Time.now
      super
    end

    class << self
      def request(params)
        fields.inject(Solve) do |result, field|
          field.filter(result, params)
        end
      end

      def fields
        [Solver, Competition, Puzzle, SolveTime]
      end
    end
  end
end
