require_relative "spec_helper"

ReconDatabase::Solve.db = Sequel::Model.db

module ReconDatabase
  describe Solve do

    let(:regular_solve) { Solve.new(time: 10.00) }
    let(:plus_two_solve) { Solve.new(time: 10.00, penalty: "+2") }
    let(:dnf_solve) { Solve.new(time: 10.00, penalty: "dnf") }

    describe "effective value" do
      it "is the time of the solve" do
        regular_solve.effective_value.must_equal 10.00
      end

      it "is the time plus two with a plus two penalty" do
        plus_two_solve.effective_value.must_equal 12.00
      end

      it "is the time for a dnf" do
        dnf_solve.effective_value.must_equal 10.00
      end
    end

    describe "formatting" do
      it "is just the time for no penalty" do
        regular_solve.format.must_equal "10.00"
      end

      it "is the penalty time with a + for a +2" do
        plus_two_solve.format.must_equal "12.00+"
      end

      it "is DNF(<time>) for a dnf" do
        dnf_solve.format.must_equal "DNF(10.00)"
      end
    end

    describe "penalties" do
      it "knows when it is a dnf" do
        dnf_solve.dnf?.must_equal true
        regular_solve.dnf?.must_equal false
      end

      it "knows when it is a +2" do
        plus_two_solve.plus_two?.must_equal true
        regular_solve.plus_two?.must_equal false
      end
    end

    describe "request" do

      before do
        Solve.all.each { |solve| solve.destroy }
        Solve.new(time: 10.00, solver: "Forte").save
        Solve.new(time: 11.00, solver: "Kris").save
        Solve.new(time: 12.00, solver: "Jon").save
        Solve.new(time: 13.00, solver: "Thompson").save
      end

      it "ignores blank fields" do
        Solve.request(solver: "Forte", competition: "").count.must_equal 1
      end

      it "filters based on time" do
        Solve.request("time-specifier" => "less",
                      "time-value" => "12.5").count.must_equal 3
        Solve.request("time-specifier" => "less",
                      "time-value" => "11").count.must_equal 1
      end
    end

  end
end
