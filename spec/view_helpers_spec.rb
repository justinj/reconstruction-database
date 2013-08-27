module RCDB
  describe ViewHelpers do
    include RCDB::ViewHelpers

    it "creates garron links" do
      solve = stub(solution: "R' U",
                   scramble: "U' R")
      
      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
        .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2"
    end
  end
end
