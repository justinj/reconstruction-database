module RCDB
  describe Competition do
    it "generates its url" do
      Competition.new(code: "WC2013").url.must_equal "https://www.worldcubeassociation.org/results/c.php?i=WC2013"
    end

    it "guesses the competition code if there isn't one" do
      Competition.new(name: "Zune Open 2012").url.must_equal "https://www.worldcubeassociation.org/results/c.php?i=ZuneOpen2012"
    end

    it "formats as a link if it is official" do
      Competition.new(name: "Zune Open 2012").at.must_match /href/
    end

    it "formats as a name if it is unofficial" do
      Competition.new(name: "Unofficial").at.must_equal ""
    end
  end
end
