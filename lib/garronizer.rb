module RCDB
  class Garronizer
    class << self
      def garronize(solve)
        params = {
          "alg" => escape_chars(solve.canonical_solution),
          "setup" => escape_chars(solve.scramble),
          "type" => animtype(solve),
          "puzzle" => solve.puzzle.garronized_name,
          "title" => garron_title(solve),
        }
        garron_url_from_params(params)
      end

      private

      def garron_url_from_params(params)
        url_params = params.reject { |k, v| v.blank? }
        .map { |k, v| "#{k}=#{v}"}.join("&")
        "http://alg.cubing.net/?#{url_params}"
      end

      def escape_chars(alg)
        alg.tr("' ", "-_").gsub("\n","%0A")
      end

      # if we don't have a scramble we need to set the 'animtype' to
      # have it set the cube up by doing the inverse of the solution
      def animtype(solve)
        solve.scramble.blank? ? "reconstruction-end-with-setup" : "reconstruction"
      end

      def garron_title(solve)
        solve.solver.name
      end
    end
  end
end
