helpers do
  def format_solution(solution)
    solution = solution.gsub("\n", "<br>")
    solution.gsub(/(\/\/.*?<br>)/,
                  '<span class="comment">\1</span>')
  end
end
