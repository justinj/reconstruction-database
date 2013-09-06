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

    def format_solution(solution)
      solution = h(solution.to_s).gsub("\n", "<br>")
      delimiter = "&#x2F;&#x2F;"
        solution.gsub(/(#{delimiter}.*?(<br>|$))/,
                      '<span class="comment">\1</span>')
    end

    def garronize(solve)
      solution = render_solution(solve)
      alg = garronize_alg(solve.solution)
      ini = garronize_alg(solve.scramble)
      puz = solve.puzzle.garronized_name
      "http://alg.garron.us/?alg=#{alg}&ini=#{ini}&cube=#{puz}" 
    end

    def ksim_link(solve)
      "http://snk.digibase.ca/ksim.htm?colours=white,lime,red,yellow,blue,orange&alg=#{@solve.scramble.gsub(/\s/,"")}"
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
