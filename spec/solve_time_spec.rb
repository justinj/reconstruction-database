require_relative "spec_helper" 

module ReconDatabase
  describe SolveTime do
    describe "filtering" do

      let(:dataset){ Minitest::Mock.new }

      describe "not occurring" do
        it "doesn't filter if the keys aren't present" do
          dataset.expect(:where, []) { raise "Should not be called" }
          SolveTime.filter_solves(dataset, {})
        end
      end

      describe "occurring" do
        after do
          dataset.verify
        end

        it "filters less than when the time-specifier is 'less'" do
          dataset.expect(:where, [], ["time < ?", 10.00])
          SolveTime.filter_solves(dataset, {"time-specifier" => "less",
                                     "time-value" => 10.00})
        end

        it "filters greater than when the time-specifier is 'greater'" do
          dataset.expect(:where, [], ["time > ?", 11.00])
          SolveTime.filter_solves(dataset, {"time-specifier" => "greater",
                                     "time-value" => 11.00})
        end

        it "filters equal than when the time-specifier is 'equal'" do
          dataset.expect(:where, [], ["time = ?", 12.00])
          SolveTime.filter_solves(dataset, {"time-specifier" => "equal",
                                     "time-value" => 12.00})
        end
      end
    end
  end
end
