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

    def at(location)
      if location.nil? || location == "Unofficial"
        ""
      else
        "at #{location}"
      end
    end
  end
end
