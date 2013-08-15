module ReconDatabase
  class SolveFactory
    class << self
      def from_hash(solve)
        solver = Solver.where(name: solve[:solver]).first || Solver.new(name: solve[:solver])
        solver.save
        puzzle = Puzzle.where(name: solve[:puzzle]).first || Puzzle.new(name: solve[:puzzle])
        puzzle.save
        competition = Competition.where(name: solve[:competition]).first || Competition.new(name: solve[:competition])
        competition.save

        new_solve = Solve.new
        new_solve.solver = solver
        new_solve.puzzle = puzzle
        new_solve.competition = competition

        new_solve.time = solve[:time]
        new_solve.scramble = solve[:scramble]
        new_solve.penalty = solve[:penalty]
        new_solve.youtube = solve[:youtube]

        new_solve.reconstructor = solve[:source]
        new_solve.source_content = solve[:source_content]

        new_solve
      end
    end
  end
end
