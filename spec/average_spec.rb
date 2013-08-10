require_relative "spec_helper"

ReconDatabase::Average.db = Sequel::Model.db

module ReconDatabase
  describe Average do
    before do
      @solves = [
        Solve.new(time: 11.91, penalty: "dnf"),
        Solve.new(time: 12.25),
        Solve.new(time: 7.65),
        Solve.new(time: 8.96),
        Solve.new(time: 9.13)
      ]
      @average = Average.new
      @average.save
      @solves.each { |solve| @average.add_solve(solve) }
    end

    it "gets all the solves in an average" do
      @average.solves.count.must_equal 5
    end

    it "calculates the average" do
      @average.result.must_equal "10.11"
    end
  end
end
