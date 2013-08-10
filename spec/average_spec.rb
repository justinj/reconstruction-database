require_relative "spec_helper"

ReconDatabase::Average.db = Sequel::Model.db

module ReconDatabase
  describe Average do

    def with_times(*times)
      average = Average.new
      average.save
      times.each { |time| average.add_solve(Solve.new(time: time)) }
      average
    end
    
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

    describe "calculations" do
      describe "best" do
        it "figures out the best solve" do
          with_times(1,2,3).best.time.must_equal 1
        end

        it "considers penalties" do
          average = with_times(1,2,3)
          average.solves.first.penalty = "+2"
          average.best.time.must_equal 2
        end

        it "considers dnfs" do
          average = with_times(1,2,3)
          average.solves.first.penalty = "dnf"
          average.best.time.must_equal 2
        end
      end
    end

    describe "format" do
      it "puts parens around the best and worst solves" do
        with_times(1,2,3).format.must_equal "(1.00), 2.00, (3.00)"
      end
    end

    it "gets all the solves in an average" do
      @average.solves.count.must_equal 5
    end

    it "calculates the average" do
      @average.result.must_equal "10.11"
    end
  end
end
