module RCDB
  module PuzzleRenamer
    module_function
    def rename(puzzle_name)
      different_names[puzzle_name] || puzzle_name
    end

    def different_names
      @different_names ||= flip_hash(names)
    end

    def names
      {
        "3x3BLD" => ["3bld"],
        "3x3" => ["3x3x3"]
      }
    end

    def flip_hash(input)
      input.each_with_object({}) do |(desired, actual), hsh|
        actual.each { |value| hsh[value] = desired }
      end
    end
  end
end
