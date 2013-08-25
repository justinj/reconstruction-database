module ReconDatabase
  describe ViewHelpers do
    include ReconDatabase::ViewHelpers
    it "properly formats comments" do
      skip
      format_solution("hello //comment<br>hi // other comment").must_equal 'hello <span class="comment">//comment<br></span>hi <span class="comment">// other comment</span>'
    end

    it "creates garron links" do
      solve = stub

      solve.stubs(:solution).returns("R' U")
      solve.stubs(:scramble).returns("U' R")
      
      solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
      garronize(solve)
        .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2"
    end
  end
end
