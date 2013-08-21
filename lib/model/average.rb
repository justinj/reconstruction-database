module ReconDatabase
  class Average < Sequel::Model
    include FormattingUtils
    one_to_many :solves, class: Solve
    many_to_one :solver
    many_to_one :puzzle
    many_to_one :competition

    def result
      if mean?
        mean
      elsif average?
        avg
      else
        "N/A"
      end
    end

    def mean?
      solves.count == 3
    end

    def average?
      solves.count > 3
    end

    def mean
      round(sum / solves.count)
    end

    def avg
      bestval = best.effective_value
      worstval = worst.effective_value
      trimmed_sum = sum - bestval - worstval
      average = trimmed_sum / (solves.count - 2)
      round(average)
    end

    def round(average)
      (average * 100.0).round / 100.0
    end

    def sum
      solves.map(&:effective_value).inject(&:+)
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
