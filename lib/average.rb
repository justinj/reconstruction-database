module ReconDatabase
  class Average < Sequel::Model
    one_to_many :solves, class: Solve

    def result
      p best(solves)
      p worst(solves)

      sum = solves.collect(&:time).inject(&:+) - best(solves).time - worst(solves).time
      p sum
      sum / (solves.count - 2)
    end

    def worst(solves)
      solves.max_by(&:time)
    end

    def best(solves)
      solves.min_by(&:time)
    end

    # seriously?
    def add_solve(*args)
      add_solf(*args)
    end

    def remove_solve(*args)
      remove_solf(*args)
    end
  end
end
