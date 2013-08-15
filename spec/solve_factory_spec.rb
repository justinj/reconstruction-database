require_relative "spec_helper"

module ReconDatabase
  describe SolveFactory do
    before do
      setup_db
    end

    let(:new_solve) do
      {
        time: 10.00,
        competition: "Notreal 2012"
      }
    end

    it "adds a solve from a hash" do
      SolveFactory.from_hash(new_solve).must_be_instance_of Solve
    end

    it "adds a new competition if one does not exist" do
      Competition.count.must_equal 0
      SolveFactory.from_hash(new_solve).save
      Competition.count.must_equal 1
    end

    it "doesn't add a new competition if it does exist" do
      Competition.count.must_equal 0
      SolveFactory.from_hash(new_solve)
      SolveFactory.from_hash(competition: "Notreal 2012")
      Competition.count.must_equal 1
    end
  end
end
