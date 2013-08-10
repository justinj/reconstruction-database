require_relative "spec_helper"

ReconDatabase::Solve.db = Sequel::Model.db

module ReconDatabase
  describe Solve do

    before do
      Solve.all.each { |solve| solve.destroy }
      @solves = [
        Solve.new(time: 10.00, solver: "Forte").save,
        Solve.new(time: 11.00, solver: "Kris").save,
        Solve.new(time: 12.00, solver: "Jon").save,
        Solve.new(time: 13.00, solver: "Thompson").save
      ]
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

    describe "penalties" do
      it "knows when it is a dnf" do
        Solve.new(penalty: "dnf").dnf?.must_equal true
        Solve.new(penalty: "").dnf?.must_equal false
      end

      it "knows when it is a +2" do
        Solve.new(penalty: "+2").plus_two?.must_equal true
        Solve.new(penalty: "").plus_two?.must_equal false
      end
    end
  end
end