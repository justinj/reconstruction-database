module RCDB
  module ViewHelpers
    def text_input(title, value, name)
  %(<label>#{title}</label>
  <textarea name="#{name}" class="form-control"
    rows="#{value.to_s.lines.count}" >#{value}</textarea>)
    end

    def date_added(solve)
      solve.date_added.strftime("%b %-d, %Y")
    end

    def format_solution(solution)
      solution = h(solution.to_s).gsub("\n", "<br>")
      delimiter = "&#x2F;&#x2F;"
      solution.gsub(/(#{delimiter}.*?(<br>|$))/,
                    '<span class="comment">\1</span>')
    end

    def garronize(solve)
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
