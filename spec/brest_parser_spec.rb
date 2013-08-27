require_relative "spec_helper" 
module RCDB
  describe BrestParser do
    attr_reader :parser
    attr_reader :solve
    attr_reader :non_333
    attr_reader :multiple

    before do
      @parser = BrestParser.new(fixture "feliks_588_wc_2013")
      @solve = @parser.solves.first
      @non_333 = BrestParser.new(fixture "non_333_reconstruction").solves.first
      @multiple = BrestParser.new(fixture "multiple_solves")
    end

    it "parses the solver" do
      solve[:solver].must_equal "Feliks Zemdegs"
    end

    it "parses the time" do
      solve[:time].must_equal 5.88
    end

    it "parses the scramble" do
      solve[:scramble].must_equal "U' B2 L2 D2 F2 U L2 D' B' L' U' R F2 D2 F U' R D'"
    end

    it "parses the youtube video" do
      solve[:youtube].must_equal "VF30pZM-twA"
    end

    it "parses the solution" do
      expected = "x' // inspection
R D R D R' // cross
U R U R' y' U' R' U R // 1st pair
d R' F R F' R' U' R // 2nd pair
U R U R' // 3rd pair
U' L' U2 L U L' U2 L // 4th pair
r U2' R' U' R U' r' // OLL(CP)
U' R U' R U R U R U' R' U' R2 U' // EPLL"

      solve[:solution].must_equal expected
    end

    it "parses the competition" do
      solve[:competition].must_equal "World Rubik's Cube Championship 2013"
    end

    it "parses the puzzle" do
      solve[:puzzle].must_equal "3x3"
      non_333[:puzzle].must_equal "4x4"
    end

    it "parses multiple solves" do
      multiple.solves.count.must_equal 2
    end

    it "finds the scrambles for multiple solves" do
      multiple.solves[0][:scramble].must_equal "B2 U2 R2 D U2 F2 L' D' B2 L2 R' B2 F' D L B' U' B U'"
      multiple.solves[1][:scramble].must_equal "D2 F' U2 L2 R' F' D' L' D L' R2 F2 R D L' R2 U F'"
    end

    it "finds the name for multiple solves" do
      multiple.solves[0][:solver].must_equal "Feliks Zemdegs"
      multiple.solves[1][:solver].must_equal "Feliks Zemdegs"
    end

    it "parses multiple times" do
      multiple.solves[0][:time].must_equal 8.39
      multiple.solves[1][:time].must_equal 7.95
    end
  end

  describe "two by two reconstructions" do
    attr_reader :parser, :solves
    # These didn't parse properly at first

    before do
      @parser = BrestParser.new(fixture "5_2x2_solves")
      @solves = @parser.solves
    end

    it "can tell there are 5 solves" do
      solves.count.must_equal 5
    end
  end

  describe "penalties" do
    attr_reader :parser, :solves

    before do
      @parser = BrestParser.new(fixture "solve_with_dnf")
      @solves = @parser.solves
    end

    it "can tell the first solve is a dnf" do
      @solves.first[:penalty].must_equal "dnf"
    end

    it "can tell the second solve is not a dnf" do
      @solves[1][:penalty].must_equal ""
    end
  end
end
