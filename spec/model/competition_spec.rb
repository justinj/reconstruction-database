module RCDB
  describe Competition do
    it "generates its url" do
      Competition.new(code: "WC2013").url.must_equal "https://www.worldcubeassociation.org/results/c.php?i=WC2013"
    end

    it "guesses the competition code if there isn't one" do
      Competition.new(name: "Zune Open 2012").url.must_equal "https://www.worldcubeassociation.org/results/c.php?i=ZuneOpen2012"
    end
  end
end
