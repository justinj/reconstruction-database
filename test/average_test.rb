require_relative "test_helper"

ReconDatabase::Average.db = Sequel::Model.db

module ReconDatabase
  class AverageTest < Minitest::Test
    def setup
      @solves = [
        Solve.new(time: 11.91),
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
      # THE PROBLEM HERE
      # is that we don't store penalties,
      # so the 11.91 DNF is counted as just an 11.91
      assert_equal 10.13, @average.result
    end
  end
end
