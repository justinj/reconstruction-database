module RCDB
  class << self
    def seed_db
      %w(2x2 3x3 4x4 5x5 6x6 7x7 pyraminx).each do |puzzle|
        Puzzle.new(name: puzzle).save
      end
    end
  end
end
