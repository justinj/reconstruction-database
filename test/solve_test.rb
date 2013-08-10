require_relative "test_helper"

ReconDatabase::Solve.db = Sequel::Model.db

module ReconDatabase
  class SolveTest < Minitest::Test

    def setup
      Solve.all.each { |solve| solve.destroy }
      @solves = [
        Solve.new(time: 10.00, solver: "Forte").save,
        Solve.new(time: 11.00, solver: "Kris").save,
        Solve.new(time: 12.00, solver: "Jon").save,
        Solve.new(time: 13.00, solver: "Thompson").save
      ]
    end

    def test_request_ignores_blank_fields
      assert_equal 1, Solve.request(solver: "Forte", competition: "").count
    end

    def test_request_time
      assert_equal 3, Solve.request("time-specifier" => "less",
                                    "time-value" => "12.5").count
      assert_equal 1, Solve.request("time-specifier" => "less",
                                    "time-value" => "11").count
    end
  end
end
