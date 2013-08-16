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

    def tablify(stats)
      stats = stats.dup.lines
      # ugh, formatting this is terrible
      stats[2] = "<td></td>"*5 + stats[2]
      "<table class='statstable'>" + 
      stats.map { |line| line.split /\t+/ }.map do |row|
        "<tr><td>" + row.join("</td><td>") + "</td></tr>"
      end.join("\n") + 
        "</table>"
    end

  end
end
