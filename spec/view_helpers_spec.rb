module RCDB
  describe ViewHelpers do
    include RCDB::ViewHelpers

    it "creates garron links" do
      solve = stub(solution: "R' U",
                   scramble: "U' R")

      stubs(:render_solution).returns("R' U")
      
      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
        .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2"
    end

    it "formats the date of a solve" do
      date = Date.new(2010,8,10)
      date_added(stub(date_added: date)).must_equal "Aug 10, 2010"
    end
  end
end
