module RCDB
  describe Tag do
    it "allows solves with the given tag" do
      dataset = mock
      dataset.expects(:where).once
      Tag.filter_solves(dataset, {"tags" => "tag"})
    end
  end
end
