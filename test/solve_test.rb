require_relative "test_helper"

module ReconDatabase
  class SolveTest < Minitest::Test

    def setup
    end

    def test_query
      SolveDatabase.stub :where, [{solver: "Keemy"}] do
        result = Solve.query({}).first
        assert result.solver == "Keemy"
      end
    end
  end
end
