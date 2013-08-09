class ViewHelpersTest < Minitest::Test
  include ReconDatabase::ViewHelpers
  def test_format_comment
    assert_equal 'hello <span class="comment">//comment<br></span>hi <span class="comment">// other comment</span>', format_solution("hello //comment<br>hi // other comment")
  end

end
