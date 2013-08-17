module ReconDatabase
  describe Puzzle do
    describe "garronization" do
      it "is garronizable if it's a cubic puzzle" do
        Puzzle.new(name: "2x2").must_be :garronizable?
      end

      it "is not garronizable if its not a cubic puzzle" do
        Puzzle.new(name: "pyraminx").wont_be :garronizable?
      end

      it "has a garronized name" do
        Puzzle.new(name: "2x2").garronized_name.must_equal "2x2x2"
        Puzzle.new(name: "3x3").garronized_name.must_equal "3x3x3"
        Puzzle.new(name: "3x3OH").garronized_name.must_equal "3x3x3"
        Puzzle.new(name: "3x3Feet").garronized_name.must_equal "3x3x3"
      end
    end
  end
end
