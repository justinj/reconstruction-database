require_relative "spec_helper"

ReconDatabase::Average.db = Sequel::Model.db

module ReconDatabase
  describe Average do

    def with_times(*times)
      average = Average.new
      average.save
      solves = times.map { |time| stub(effective_value: time.to_f,
                                       dnf?: false,
                                       format: "#{time}!!") }
      average.stubs(:solves).returns(solves)
      average
    end
    
    describe "calculations" do
      describe "best/worst" do
        it "figures out the best solve" do
          with_times(1,2,3).best.effective_value.must_equal 1
          with_times(1,2,3).worst.effective_value.must_equal 3
        end

        it "considers dnfs" do
          average = with_times(1,2,3)
          average.solves.first.stubs(:dnf?).returns(true)
          average.best.effective_value.must_equal 2
          average.worst.dnf?.must_equal true
        end
      end

      describe "calculating average" do
        it "calculates it correctly" do
          with_times(1, 2, 3, 4).result.must_equal 2.5
        end

        it "ignores the best and worst times" do
          with_times(1, 2, 2, 100).result.must_equal 2
        end

        it "does a mean if there are exactly 3 times" do
          with_times(1, 2, 6).result.must_equal 3
        end
      end
    end

    describe "format" do
      it "puts parens around the best and worst solves" do
        with_times(1,2,3,4).format.must_equal "(1!!), 2!!, 3!!, (4!!)"
      end

      it "doesn't put parens for a mean" do
        with_times(1,2,3).format.must_equal "1!!, 2!!, 3!!"
      end
    end
  end
end
