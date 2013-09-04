module RCDB
  class Solver < Sequel::Model
    extend Field
    one_to_many :averages

    def to_s
      name.to_s
    end
  end
end
