class Solve
  attr_accessor :solver, :scramble, :solution, :time, :id

  def initialize(args)
    @solver = args[:solver]
    @scramble = args[:scramble]
    @solution = args[:solution]
    @time = args[:time]
  end

  def inspect
    "#@time:#@solver"
  end

  class << self
    @@solves = []
    def all
      @@solves.dup
    end

    def add(solve)
      solve.id = @@solves.count
      @@solves << solve
    end

    def get(id)
      @@solves[id]
    end

    def by(who)
      who = who
      @@solves.select { |solve| solve.solver == who }
    end

    def solvers
      @@solves.map(&:solver).uniq
    end
  end
end
