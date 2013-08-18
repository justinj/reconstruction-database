module ReconDatabase
  describe Competition do
    it "generates its url" do
      Competition.new(code: "WC2013").url.must_equal "https://www.worldcubeassociation.org/results/c.php?i=WC2013"
    end
  end
end
