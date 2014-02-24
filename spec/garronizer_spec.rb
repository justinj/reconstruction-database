module RCDB
  describe Garronizer do
    def garronize(solve)
      Garronizer.garronize(solve)
    end
    it "creates garron links for a solve" do
      solve = stub(canonical_solution: "R U R' U'",
                   scramble: "U R U' R'",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      expected = "http://alg.cubing.net/?alg=R_U_R-_U-&setup=U_R_U-_R-&type=reconstruction&puzzle=3x3&title=Justin"
      garronize(solve).must_equal expected
    end

    it "changes the type if there is no scramble" do
      solve = stub(canonical_solution: "R",
                   scramble: "",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      expected =  "http://alg.cubing.net/?alg=R&type=reconstruction-end-with-setup&puzzle=3x3&title=Justin"
      garronize(solve).must_equal expected
    end

    it "creates garron links for other puzzles" do
      solve = stub(canonical_solution: "R' U",
                   solver: stub(name: "Justin"),
                   scramble: "U' R")


      stubs(:render_solution).returns("R' U")

      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
      .must_equal "http://alg.cubing.net/?alg=R-_U&setup=U-_R&type=reconstruction&puzzle=2x2x2&title=Justin"
    end

    it "removes links from names" do
      solve = stub(canonical_solution: "R' U",
                   solver: stub(name: "Justin"),
                   scramble: "U' R")


      stubs(:render_solution).returns("R' U")

      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
      .must_equal "http://alg.cubing.net/?alg=R-_U&setup=U-_R&type=reconstruction&puzzle=2x2x2&title=Justin"
    end

  end
end
