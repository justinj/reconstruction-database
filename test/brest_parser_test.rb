require "minitest/autorun"

class BrestParserTest < Minitest::Test
  attr_reader :parser
  attr_reader :solve
  attr_reader :non_333
  attr_reader :multiple

  def setup
    @parser = BrestParser.new("test/fixtures/feliks_588_wc_2013")
    @solve = @parser.solves.first
    @non_333 = BrestParser.new("test/fixtures/non_333_reconstruction").solves.first
    @multiple = BrestParser.new("test/fixtures/multiple_solves")
  end

  def test_parse_solver
    assert_equal "Feliks Zemdegs", solve[:solver]
  end

  def test_parse_time
    assert_equal 5.88, solve[:time]
  end

  def test_parse_scramble
    assert_equal "U' B2 L2 D2 F2 U L2 D' B' L' U' R F2 D2 F U' R D'", solve[:scramble]
  end

  def test_parse_youtube
    assert_equal "VF30pZM-twA", solve[:youtube]
  end

  def test_parse_solution
    expected = "x' // inspection
R D R D R' // cross
U R U R' y' U' R' U R // 1st pair
d R' F R F' R' U' R // 2nd pair
U R U R' // 3rd pair
U' L' U2 L U L' U2 L // 4th pair
r U2' R' U' R U' r' // OLL(CP)
U' R U' R U R U R U' R' U' R2 U' // EPLL"

    assert_equal expected, solve[:solution]
  end

  def test_parse_competition
    assert_equal "World Rubik's Cube Championship 2013", solve[:competition]
  end

  def test_save

    expected_hash = {
      scramble: solve[:scramble],
      solution: solve[:solution],
      solver: solve[:name],
      time: solve[:time],
      youtube: solve[:youtube],
      competition: solve[:competition],
      puzzle: solve[:puzzle]
    }

    db = Minitest::Mock.new
    db.expect(:add, nil, [expected_hash])
    parser.save_to(db)
    db.verify
  end

  def test_puzzle
    assert_equal "3x3", solve[:puzzle]
  end

  def test_non_333_puzzle
    assert_equal "4x4", non_333[:puzzle]
  end

  def test_multiple_solves
    assert_equal 2, multiple.solves.count
  end

  def test_multiple_finds
    assert_equal "B2 U2 R2 D U2 F2 L' D' B2 L2 R' B2 F' D L B' U' B U'", multiple.solves[0][:scramble]
    assert_equal "D2 F' U2 L2 R' F' D' L' D L' R2 F2 R D L' R2 U F'", multiple.solves[1][:scramble]
  end
end
