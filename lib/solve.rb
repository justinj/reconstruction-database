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
      @@solves
    end

    def add(solve)
      solve.id = @@solves.count
      @@solves << solve
    end

    def get(id)
      @@solves[id]
    end
  end
end
