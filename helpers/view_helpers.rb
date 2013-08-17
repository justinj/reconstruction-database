module ReconDatabase
  module ViewHelpers
    def date_added(solve)
      solve.date_added.strftime("%b %-d, %Y")
    end

    def format_solution(solution)
      solution = solution.to_s.gsub("\n", "<br>")
      solution.gsub(/(\/\/.*?(<br>|$))/,
                    '<span class="comment">\1</span>')
    end

    def garronize(solve)
      alg = garronize_alg(solve.solution)
      ini = garronize_alg(solve.scramble)
      puz = solve.puzzle.garronized_name
      "http://alg.garron.us/?alg=#{alg}&ini=#{ini}&cube=#{puz}" 
    end

    private

    def garronize_alg(alg)
      alg.tr("' ", "-_").gsub("\n","%0A")
    end

    def cubic?(puzzle)
      puzzle.name =~ /\dx\d/
    end
  end
end
