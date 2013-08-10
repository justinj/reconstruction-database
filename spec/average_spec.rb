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
    
    describe "calculations" do
      describe "best/worst" do
        it "figures out the best solve" do
          with_times(1,2,3).best.time.must_equal 1
          with_times(1,2,3).worst.time.must_equal 3
        end

        it "considers penalties" do
          average = with_times(1,2,2.5)
          average.solves.first.penalty = "+2"
          average.best.time.must_equal 2
          average.worst.effective_value.must_equal 3
        end

        it "considers dnfs" do
          average = with_times(1,2,3)
          average.solves.first.penalty = "dnf"
          average.best.time.must_equal 2
          average.worst.dnf?.must_equal true
        end
      end

      describe "calculating average" do
        it "calculates it correctly" do
          with_times(1, 2, 3).result.must_equal 2
        end

        it "ignores the best and worst times" do
          with_times(1, 2, 100).result.must_equal 2
        end
      end
    end

    describe "format" do
      it "puts parens around the best and worst solves" do
        with_times(1,2,3).format.must_equal "(1.00), 2.00, (3.00)"
      end
    end
  end
end
