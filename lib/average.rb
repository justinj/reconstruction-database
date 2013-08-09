module ReconDatabase
  class Average < Sequel::Model
    include FormattingUtils
    one_to_many :solves, class: Solve

    def result
      sum = solves.collect(&:time).inject(&:+) - best.time - worst.time
      format_time(sum / (solves.count - 2))
    end

    def worst
      dnf = solves.detect { |solve| solve.penalty == "dnf" }
      dnf || solves.max_by(&:time)
    end

    def best
      solves.min_by(&:time)
    end

    # seriously?
    def add_solve(*args)
      add_solf(*args)
    end

    def remove_solve(*args)
      remove_solf(*args)
    end
  end
end
