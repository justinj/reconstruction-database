module ReconDatabase
  describe ViewHelpers do
    include ReconDatabase::ViewHelpers
    it "properly formats comments" do
      format_solution("hello //comment<br>hi // other comment").must_equal 'hello <span class="comment">//comment<br></span>hi <span class="comment">// other comment</span>'
    end
  end
end
