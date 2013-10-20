module RCDB
  describe Garronizer do
    def garronize(solve)
      Garronizer.garronize(solve)
    end
    it "creates garron links for a solve" do
      solve = stub(solution: "R U R' U'",
                   scramble: "U R U' R'",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      expected = "http://alg.garron.us/?alg=R_U_R-_U-&ini=U_R_U-_R-&cube=3x3&name=Justin"
      garronize(solve).must_equal expected
    end

    it "adds &displines=0 to solutions longer than 12 lines" do
      solution = (["R"] * 13).join("\n")
      solve = stub(solution: solution,
                   scramble: "U",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      expected =  "http://alg.garron.us/?alg=R%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR&ini=U&cube=3x3&name=Justin&displines=0"
      garronize(solve).must_equal expected
    end

    it "adds &animtype=solve if there is no scramble" do
      solve = stub(solution: "R",
                   scramble: "",
                   solver: stub(name: "Justin"),
                   puzzle: stub(garronized_name: "3x3"))
      expected =  "http://alg.garron.us/?alg=R&animtype=solve&cube=3x3&name=Justin"
      garronize(solve).must_equal expected
    end

    it "creates garron links" do
      solve = stub(solution: "R' U",
                   solver: stub(name: "Justin"),
                   scramble: "U' R")


      stubs(:render_solution).returns("R' U")

      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
      .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2&name=Justin"
    end

    it "removes links from names" do
      solve = stub(solution: "R' U",
                   solver: stub(name: "Justin"),
                   scramble: "U' R")


      stubs(:render_solution).returns("R' U")

      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
      .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2&name=Justin"
    end

  end
end
