module RCDB
  class Step < Sequel::Model
    many_to_one :solve
  end
end
