module ReconDatabase
  class Solver < Sequel::Model
    extend Field
    one_to_many :solves, class: Solve

    def to_s
      name
    end
  end
end