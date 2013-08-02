require "minitest/autorun"

class PostParserTest < Minitest::Test
  attr_accessor :post

  def test_no_solves
    for_test_case("no_solves")
    assert post.solves.count == 0
  end

  def test_single_solve
    for_test_case("single_solve")
    assert post.solves.count == 1
  end

  def for_test_case(test_case)
    @post = PostParser.new(File.read("fixtures/#{test_case}"))
  end
end


class PostParser
  def initialize(post_content)
  end

  def solves
    []
  end
end
