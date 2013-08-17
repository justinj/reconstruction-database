module ReconDatabase
  describe ViewHelpers do
    include ReconDatabase::ViewHelpers
    it "properly formats comments" do
      format_solution("hello //comment<br>hi // other comment").must_equal 'hello <span class="comment">//comment<br></span>hi <span class="comment">// other comment</span>'
    end

    it "creates garron links" do
      garronize(Solve.new(scramble: "U' R", solution: "R'\nU", puzzle: "2x2"))
        .must_equal "http://alg.garron.us/?alg=R-%0AU&ini=U-_R&cube=2x2x2"

      garronize(Solve.new(scramble: "U' R", solution: "R'\nU", puzzle: "4x4"))
        .must_equal "http://alg.garron.us/?alg=R-%0AU&ini=U-_R&cube=4x4x4"
    end
  end
end
