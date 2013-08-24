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
        it "gives N/A when there aren't enough solves" do
          with_times(1, 2).result.must_equal "N/A"
        end
        it "calculates it correctly" do
          with_times(1, 2, 3, 4).result.must_equal 2.5
        end

        it "ignores the best and worst times" do
          with_times(1, 2, 2, 100).result.must_equal 2
        end

        it "does a mean if there are exactly 3 times" do
          with_times(1, 2, 6).result.must_equal 3
        end

        it "rounds properly" do
          with_times(12.15, 14.53, 13.27, 12.58, 10.77).result.must_equal 12.67
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


    describe "publishing" do
      let(:user) { User.new(name: "name", password: "pass") }
      let(:average) { Average.new }
      it "starts out hidden" do
        average.visible?.must_equal false 
      end

      it "can be made public" do
        average.publish
        average.visible?.must_equal true
      end
    end
  end
end
