module RCDB
  class Reconstructor < Sequel::Model
    extend Field
    one_to_many :solves, class: Solve

    def to_s
      name || ""
    end

    def self.visible?
      false
    end
  end
end
