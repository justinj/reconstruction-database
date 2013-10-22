module RCDB
  describe BrestParser do
    attr_reader :parser
    attr_reader :rpg_parser
    attr_reader :solve
    attr_reader :non_333
    attr_reader :multiple

    before do
      BrestStats.stubs(:parse)
      @parser = BrestParser.new(fixture_post "feliks_588_wc_2013")
      @rpg_parser = BrestParser.new(fixture_post "rpg")
      @solve = @parser.solves.first
      @non_333_parser = BrestParser.new(fixture_post "non_333_reconstruction")
      @non_333 = @non_333_parser.solves.first
      @multiple = BrestParser.new(fixture_post "multiple_solves")
    end

    it "parses RPG posts properly" do
      rpg_parser.solves.first[:scramble].must_equal "F D R U F' L D F2 U' R B2 R D2 L' B2 U2 D2 R' F2 R'"
    end

    it "asks BrestParser to parse the stats" do
      BrestStats.unstub(:parse)
      BrestStats.expects(:parse).with('[CODE][B]Step	Time	STM	stps	ETM	etps[/B]
[COLOR="red"]Total	5.88	53	9.01	57	9.69	[/COLOR]	[B][SIZE="4"]%[/SIZE]
							Step		Time	STM	ETM[/B]
Cross+1	1.62	13	8.02	14	8.64		Cross+1/F2L	40.2%	39.4%	38.9%
F2L	4.03	33	8.19	36	8.93		F2L/Total	68.5%	62.3%	63.2%
LL	1.85	20	10.81	21	11.35		LL/Total	31.5%	37.7%	36.8%[/CODE]')
      BrestParser.new(fixture_post "feliks_588_wc_2013").solves
    end

    it "parses the solver" do
      @parser.solver.must_equal "Feliks Zemdegs"
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
      @parser.competition.must_equal "World Rubik's Cube Championship 2013"
    end

    it "parses the puzzle" do
      @parser.puzzle.must_equal "3x3"
      @non_333_parser.puzzle.must_equal "4x4"
    end

    it "parses multiple solves" do
      multiple.solves.count.must_equal 2
    end

    it "finds the scrambles for multiple solves" do
      multiple.solves[0][:scramble].must_equal "B2 U2 R2 D U2 F2 L' D' B2 L2 R' B2 F' D L B' U' B U'"
      multiple.solves[1][:scramble].must_equal "D2 F' U2 L2 R' F' D' L' D L' R2 F2 R D L' R2 U F'"
    end

    it "sends the right stats for multiple solves" do
      BrestStats.unstub
      BrestStats.expects(:parse).with('[CODE][B]Step	Time	STM	stps	ETM	etps[/B]
[COLOR="Red"]Total	8.39	59	7.03	66	7.87	[/COLOR]	[B][SIZE="4"]%[/SIZE]
							Step		Time	STM	ETM[/B]
Cross+1	2.27	15	6.61	16	7.05		Cross+1/F2L	48.3%	46.9%	44.4%
F2L	4.70	32	6.81	36	7.66		F2L/Total	56.0%	54.2%	54.5%
LL	3.69	27	7.32	30	8.13		LL/Total	44.0%	45.8%	45.5%[/CODE]')
      BrestStats.expects(:parse).with('[CODE][B]Step	Time	STM	stps	ETM	etps[/B]
[COLOR="Red"]Total	7.95	67	8.43	74	9.31	[/COLOR]	[B][SIZE="4"]%[/SIZE]
							Step		Time	STM	ETM[/B]
Cross+1	1.59	9	5.66	10	6.29		Cross+1/F2L	32.4%	25.0%	23.3%
F2L	4.90	36	7.35	43	8.78		F2L/Total	61.6%	53.7%	58.1%
LL	3.05	31	10.16	31	10.16		LL/Total	38.4%	46.3%	41.9%[/CODE]')
      BrestParser.new(fixture_post "multiple_solves").solves
    end

    it "finds the name for multiple solves" do
      @parser.solver.must_equal "Feliks Zemdegs"
    end

    it "parses multiple times" do
      multiple.solves[0][:time].must_equal 8.39
      multiple.solves[1][:time].must_equal 7.95
    end

    describe "two by two reconstructions" do
      attr_reader :parser, :solves
      # These didn't parse properly at first

      before do
        @parser = BrestParser.new(fixture_post "5_2x2_solves")
        @solves = @parser.solves
      end

      it "can tell there are 5 solves" do
        solves.count.must_equal 5
      end
    end

    describe "penalties" do
      attr_reader :parser, :solves

      before do
        @parser = BrestParser.new(fixture_post "solve_with_dnf")
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
end
