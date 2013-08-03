class Solve
  attr_accessor :solver, 
                :scramble, 
                :solution, 
                :time, 
                :youtube,
                :competition,
                :id,
                :puzzle

  def initialize(args)
    args.each do |field, value|
      send((field.to_s + "=").to_sym, value)
    end
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

    def values_for_field(field)
      @@solves.map(&field).uniq.reject(&:nil?)
    end

    def queryable_fields
      %i(solver puzzle competition)
    end

    def matching(fields)
      fields.reduce(@@solves) do |result, (field, value)|
        result.select { |solve| value == "" || solve.send(field) == value }
      end
    end
  end
end
