module RCDB
  class Garronizer
    class << self
      def garronize(solve)
        params = {
          "alg" => escape_chars(solve.solution),
          "ini" => escape_chars(solve.scramble),
          "animtype" => animtype(solve),
          "cube" => solve.puzzle.garronized_name,
          "name" => garron_title(solve),
          "displines" => display_lines(solve.solution),
        }
        garron_url_from_params(params)
      end

      private

      def garron_url_from_params(params)
        url_params = params.reject { |k, v| v.blank? }
        .map { |k, v| "#{k}=#{v}"}.join("&")
        "http://alg.garron.us/?#{url_params}"
      end

      def escape_chars(alg)
        alg.tr("' ", "-_").gsub("\n","%0A")
      end

      # if we don't have a scramble we need to set the 'animtype' to
      # have it set the cube up by doing the inverse of the solution
      def animtype(solve)
        solve.scramble.blank? ? "solve" : ""
      end

      # when scrambles are too long, the solution being displayed covers the cube.
      # we pick 12 arbitrarily to turn off the solution being displayed.
      def display_lines(solution)
        solution.lines.count > 12 ? "0" : ""
      end

      def garron_title(solve)
        solve.solver.name
      end
    end
  end
end
