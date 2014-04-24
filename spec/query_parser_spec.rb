module RCDB
  describe QueryParser do
    describe "bare tokens" do
      it "extracts single words" do
        result = QueryParser.parse("feliks")
        result[:tokens].must_equal ["feliks"]
      end

      it "extracts multiple words separated by spaces" do
        result = QueryParser.parse("feliks zemdegs")
        result[:tokens].must_equal ["feliks", "zemdegs"]
      end

      it "extracts multiple words separated by multiple spaces or commas" do
        result = QueryParser.parse("feliks,      zemdegs")
        result[:tokens].must_equal ["feliks", "zemdegs"]
      end
    end

    describe "reconstructor declaration" do
      it "extracts the name of the reconstructor" do
        result = QueryParser.parse("reconstructor:brest")
        result[:reconstructors].must_equal ["brest"]
      end

      it "replaces '-' with ' '" do
        result = QueryParser.parse("reconstructor:justin-jaffray")
        result[:reconstructors].must_equal ["justin jaffray"]
      end

      it "does not extract reconstructors as tokens" do
        result = QueryParser.parse("reconstructor:brest")
        result[:tokens].must_equal []
      end
    end
  end
end
