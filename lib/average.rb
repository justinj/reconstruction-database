module ReconDatabase
  class Average < Sequel::Model
    include FormattingUtils
    one_to_many :solves, class: Solve

    def result
      sum = solves.collect(&:effective_value).inject(&:+) - best.effective_value - worst.effective_value
      format_time(sum / (solves.count - 2))
    end

    def worst
      dnf = solves.detect { |solve| solve.penalty == "dnf" }
      dnf || solves.max_by(&:effective_value)
    end

    def best
      non_dnf_solves.min_by(&:effective_value)
    end

    # seriously?
    def add_solve(*args)
      add_solf(*args)
    end

    def remove_solve(*args)
      remove_solf(*args)
    end

    private
    
    def non_dnf_solves
      solves.reject { |solve| solve.penalty == "dnf" }
    end
  end
end
