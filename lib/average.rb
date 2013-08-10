module ReconDatabase
  class Average < Sequel::Model
    include FormattingUtils
    one_to_many :solves, class: Solve

    def result
      sum = solves.collect(&:effective_value).inject(&:+) - best.effective_value - worst.effective_value
      sum / (solves.count - 2)
    end

    def worst
      dnf = solves.detect(&:dnf?)
      dnf || solves.max_by(&:effective_value)
    end

    def best
      non_dnf_solves.min_by(&:effective_value)
    end

    def format
      formatted_solves.join ", "
    end

    def render
      ERB.new(File.read("views/average.erb")).result(binding)
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

    def formatted_solves
      solves.map { |solve| format_solve(solve) }
    end

    def format_solve(solve)
      if solve == best || solve == worst
        "(#{solve.format})"
      else
        solve.format
      end
    end
  end
end
