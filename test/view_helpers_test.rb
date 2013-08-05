class ViewHelpersTest < Minitest::Test
  include ReconDatabase::ViewHelpers
  def test_format_comment
    assert_equal 'hello <span class="comment">//comment<br></span>hi <span class="comment">// other comment</span>', format_solution("hello //comment<br>hi // other comment")
  end

  def test_format_time
    assert_equal "10.84", format_time(10.84)
    assert_equal "10.80", format_time(10.80)
    assert_equal "1:40.15", format_time(100.15)
    assert_equal "1:04.15", format_time(64.15)
  end
end
