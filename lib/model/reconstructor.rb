module RCDB
  class Reconstructor < Sequel::Model
    one_to_many :solves, class: Solve

    def to_s
      name || ""
    end
  end
end
