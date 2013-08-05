require "minitest/autorun"
require_relative "test_helper"

module ReconDatabase
  class DatabaseTest < MiniTest::Test
    attr_reader :solves

    def setup
      SolveDatabase.test
      @solves = [{ time: 11.11, solver: "Brest" },
                { time: 22.22, solver: "Brest" },
                { time: 33.33, solver: "Eidolon"}]
      solves.each { |solve| SolveDatabase.add(solve) }
    end
    

    def test_all_inserted
      assert_equal 3, SolveDatabase.all.count
    end

    def test_get_all_solvers
      assert_equal ["Brest", "Eidolon"], SolveDatabase.every(:solver).sort
    end

    def test_where
      assert_equal 2, SolveDatabase.where({solver: "Brest"}).count
    end

    def test_where_with_time_all
      assert_equal 3, SolveDatabase.where({"time-specifier" => "less", "time-value" => "44.44"}).count
    end

    def test_where_with_time_some
      assert_equal 2, SolveDatabase.where({"time-specifier" => "less", "time-value" => "30.00"}).count
      assert_equal 1, SolveDatabase.where({"time-specifier" => "greater", "time-value" => "30.00"}).count
      assert_equal 0, SolveDatabase.where({"time-specifier" => "equal", "time-value" => "30.00"}).count
    end

  end
end
