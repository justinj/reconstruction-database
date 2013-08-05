require "minitest/autorun"
require_relative "test_helper"

module ReconDatabase
  class DatabaseTest < MiniTest::Test

    def setup
      SolveDatabase.test
    end

    def test_start_empty
      assert SolveDatabase.all.empty? 
    end

    def test_insert
      SolveDatabase.add(time: 11.11)
      refute SolveDatabase.all.empty?
    end

    def test_where
      SolveDatabase.add(time: 11.11, solver: "Brest")
      assert_equal 1, SolveDatabase.where({solver: "Brest"}).count
    end

    def test_get_all_solvers
      SolveDatabase.add(time: 11.11, solver: "Brest")
      SolveDatabase.add(time: 11.11, solver: "Eidolon")
      assert_equal ["Brest", "Eidolon"], SolveDatabase.every(:solver).sort
    end

    def test_only_has_solver_once
      SolveDatabase.add(time: 11.11, solver: "Brest")
      SolveDatabase.add(time: 11.11, solver: "Brest")
      assert_equal ["Brest"], SolveDatabase.every(:solver)
    end
  end
end
