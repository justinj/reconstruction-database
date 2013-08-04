require "minitest/autorun"

class BrestParserTest < Minitest::Test
  attr_reader :parser

  def setup
    @parser = BrestParser.new("test/fixtures/feliks_588_wc_2013")
  end

  def test_parse_single_solve
    assert parser.number_of_solves == 1
  end

  def test_parse_name
    assert_equal "Feliks Zemdegs", parser.name
  end

  def test_parse_time
    assert_equal 5.88, parser.time
  end

  def test_parse_scramble
    assert_equal "U' B2 L2 D2 F2 U L2 D' B' L' U' R F2 D2 F U' R D'", parser.scramble
  end

  def test_parse_youtube
    assert_equal "VF30pZM-twA", parser.youtube
  end

  def test_parse_solution
    expected = "x' // inspection
R D R D R' // cross
U R U R' y' U' R' U R // 1st pair
d R' F R F' R' U' R // 2nd pair
U R U R' // 3rd pair
U' L' U2 L U L' U2 L // 4th pair
r U2' R' U' R U' r' // OLL(CP)
U' R U' R U R U R U' R' U' R2 U' // EPLL
"

    assert_equal expected, parser.solution
  end

  def test_parse_competition
    assert_equal "World Rubik's Cube Championship 2013", parser.competition
  end

  def test_save
    expected_hash = {
      scramble: parser.scramble,
      solution: parser.solution,
      solver: parser.name,
      time: parser.time,
      youtube: parser.youtube,
      competition: parser.competition
    }
    db = Minitest::Mock.new
    db.expect(:add, nil, [expected_hash])
    parser.save_to(db)
    db.verify
  end
end
