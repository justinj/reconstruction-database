require_relative "test_helper"

ReconDatabase::Average.db = Sequel::Model.db

module ReconDatabase
  class AverageTest < Minitest::Test
    def setup
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

    def test_get_solves
      assert_equal 5, @average.solves.count
    end

    def test_average_result
      assert_equal "10.11", @average.result
    end
  end
end
