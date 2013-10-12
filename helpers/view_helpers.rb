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

    def date_added(solve)
      solve.date_added.strftime("%b %-d, %Y")
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

    def garronize(solve)
      solution = solve.solution
      params = {
        "alg" => garronize_alg(solution),
        "ini" => garronize_alg(solve.scramble),
        "animtype" => animtype(solve),
        "cube" => solve.puzzle.garronized_name,
        "name" => garron_name(solve),
        "displines" => display_lines(solution),
      }
      garron_from_params(params)
    end

    def garron_from_params(params)
      url_params = params.reject { |k, v| v.blank? }
                         .map { |k, v| "#{k}=#{v}"}.join("&")
      "http://alg.garron.us/?#{url_params}"
    end

    def garron_name(solve)
      remove_tags(erb :solve_summary, locals: { solve: solve })
    end

    def remove_tags(input)
      input.gsub(/<.*?>/,"")
    end

    def display_lines(solution)
      solution.lines.count > 12 ? "0" : ""
    end
    
    def animtype(solve)
      solve.scramble.blank? ? "solve" : ""
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

    private

    def garronize_alg(alg)
      alg.tr("' ", "-_").gsub("\n","%0A")
    end

    def cubic?(puzzle)
      puzzle.name =~ /\dx\d/
    end
  end
end
