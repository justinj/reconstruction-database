module RCDB
  class Puzzle < Sequel::Model
    extend Field
    one_to_many :averages

    def garronizable?
      name =~ /\dx\d/
    end

    def delimiter
      super || "//"
    end

    def garronized_name
      d = name[0]
      "#{d}x#{d}x#{d}"
    end

    def to_s
      name.to_s
    end
  end
end
