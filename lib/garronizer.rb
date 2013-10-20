module RCDB
  class Garronizer
    class << self
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

      private

      def garronize_alg(alg)
        alg.tr("' ", "-_").gsub("\n","%0A")
      end

      def animtype(solve)
        solve.scramble.blank? ? "solve" : ""
      end

      def display_lines(solution)
        solution.lines.count > 12 ? "0" : ""
      end
      def remove_tags(input)
        input.gsub(/<.*?>/,"")
      end

      def garron_from_params(params)
        url_params = params.reject { |k, v| v.blank? }
        .map { |k, v| "#{k}=#{v}"}.join("&")
        "http://alg.garron.us/?#{url_params}"
      end

      def garron_name(solve)
        solve.solver.name
      end
    end
  end

end
