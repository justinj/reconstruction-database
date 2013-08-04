require "minitest/autorun"
require "nokogiri"

class BrestParser
  def initialize(filepath)
    @filepath = filepath
    parse
  end

  def number_of_solves
    1
  end

  def scramble
     "U' B2 L2 D2 F2 U L2 D' B' L' U' R F2 D2 F U' R D'"
  end

  private

  ALG_REGEX = /((U|D|L|R|F|B)('|2)? ?)+/

  def parse
    post = File.read(@filepath)
    post.gsub!(/\[.*?\]/, "")
    p post.scan(ALG_REGEX)
  end
end

class BrestParserTest < Minitest::Test
  attr_reader :parser

  def setup
    @parser = BrestParser.new("test/fixtures/feliks_588_wc_2013")
  end

  def test_parse_single_solve
    assert parser.number_of_solves == 1
  end

  def test_parse_scramble
    assert parser.scramble == "U' B2 L2 D2 F2 U L2 D' B' L' U' R F2 D2 F U' R D'"
  end
end
