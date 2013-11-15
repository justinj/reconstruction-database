module RCDB
  module ViewHelpers

    def paginate(dataset)
      page_num = params.fetch("page", 1).to_i
      dataset.paginate(page_num, page_size)
    end

    def link(title, url, params)
      query_string = params.map { |k, v| "#{k}=#{v}" }.join("&")
      %(<a href="#{url}?#{query_string}">#{title}</a>)
    end

    def pagination_link(text, page = text)
      params.keys.each { |key| params[key] = h(params[key]) }
      link text, "/", params.merge("page" => page)
    end

    def pages_for(dataset)
      # sequel will return an enumerator in an upcoming version
      result = []
      dataset.each_page(page_size) { |page| result << page }
      result
    end

    def page_size
      100
    end

    def text_input(title, entry, field)
      erb :column_editor, locals: {title: title, 
                                   value: entry.send(field), 
                                   field_name: field}
    end

    def dropdown_input(title, entry, field)
      erb :dropdown_editor, locals: {title: title, 
                                     entry: entry, 
                                     field_name: field}
    end

    def date_added(solve)
      solve.date_added.strftime("%b %-d, %Y")
    end

    def garronize(solve)
      Garronizer.garronize(solve)
    end

    def render_solution(solve)
      erb :solution, locals: { steps: solve.steps } 
    end

    def format_solution(solution, delimiter)
      solution = escape_html(solution.to_s).gsub("\n", "<br>")
      delimiter = escape_html(delimiter)
        solution.gsub(/(#{delimiter}.*?(<br>|$))/,
                      '<span class="comment">\1</span>')
    end

    def ksim_link(solve)
      base_link = "http://snk.digibase.ca/ksim.htm?colours=white,lime,red,yellow,blue,orange&solve=#{solve.scramble.gsub(/\s/,"")},"
      steps = solve.steps.sort_by(&:position_in_solve).map(&:moves).join(",").gsub(/\s/, "")
      base_link + steps
    end

    def ellipsize(text, max = 100)
      text = text.to_s
      if text.length <= max
        text
      else
        text[0..max] + "..."
      end
    end

    def cubic?(puzzle)
      puzzle.name =~ /\dx\d/
    end
  end
end
