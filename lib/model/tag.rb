module RCDB
  class Tag < Sequel::Model
    many_to_many :solves, class: Solve, left_key: :tag_id, right_key: :solve_id
  end
end
