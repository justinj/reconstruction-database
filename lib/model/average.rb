module ReconDatabase
  class Average < Sequel::Model
    include FormattingUtils
    one_to_many :solves, class: Solve

    def result
      if mean?
        mean
      else
        avg
      end
    end

    def mean?
      solves.count == 3
    end

    def mean
      solves.collect(&:effective_value).inject(&:+) / solves.count
    end

    def avg
        sum = solves.map(&:effective_value).map(&:to_f).inject(&:+) - best.effective_value - worst.effective_value
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
    alias_method :add_solve, :add_solf
    alias_method :remove_solve, :remove_solf

    private
    
    def non_dnf_solves
      solves.reject(&:dnf?)
    end

    def formatted_solves
      solves.map { |solve| format_solve(solve) }
    end

    def format_solve(solve)
      if !mean? && (solve == best || solve == worst)
        "(#{solve.format})"
      else
        solve.format
      end
    end
  end
end
