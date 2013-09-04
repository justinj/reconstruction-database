module RCDB
  describe Tag do

    before do
      destroy_db
      @fixture = Sequel::Fixture.new :tags, DB 
    end

    let (:initial_count) { Solve.count }

    after do
      @fixture.rollback
    end

    it "does nothing when there are no tags given" do
      result = Tag.filter_solves(Solve, {})
      result.count.must_equal initial_count
    end

    it "filters out solves with the given tag" do
      result = Tag.filter_solves(Solve, {"tags" => "tag"})
      result.count.must_equal 2
    end

    it "allows solves whose average have the tag" do
      result = Tag.filter_solves(Solve, {"tags" => "average_tag"})
      result.first.id.must_equal 2
    end

    it "allows solves which have one tag in the solves and one in the average" do
      result = Tag.filter_solves(Solve, {"tags" => "tag average_tag"})
      result.first.id.must_equal 3
    end
  end
end
