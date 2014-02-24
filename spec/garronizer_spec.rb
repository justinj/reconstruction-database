module RCDB
  describe Garronizer do
    def assert_params(solve, expected_params)
      result_params = CGI.parse(URI.parse(Garronizer.garronize(solve)).query)
      expected_params.each do |key, val|
        result_params[key].first.must_equal val
      end
    end

    it "creates garron links for a solve" do
      solve = stub(canonical_solution: "R U R' U'",
                   scramble: "U R U' R'",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      assert_params(solve, {
        "alg" => "R_U_R-_U-",
        "setup" => "U_R_U-_R-",
        "type" => "reconstruction",
        "title" => "Justin"
      })
    end

    it "changes the type if there is no scramble" do
      solve = stub(canonical_solution: "R",
                   scramble: "",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      assert_params(solve, {
        "type" => "reconstruction-end-with-setup"
      })
    end

    it "creates garron links for other puzzles" do
      solve = stub(canonical_solution: "R' U",
                   solver: stub(name: "Justin"),
                   scramble: "U' R")

      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      assert_params(solve, {
        "puzzle" => "2x2x2"
      })
    end
  end
end
