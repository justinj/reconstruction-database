module RCDB
  class Puzzle < Sequel::Model
    extend Field
    one_to_many :averages

    def self.field_name
      "Event"
    end
    
    def self.query_name
      "puzzle"
    end

    def self.default
      first(name: "3x3")
    end

    def garronizable?
      name =~ /\dx\d/
    end

    # todo: polymorphize this
    def format(solve)
      case formatting_type
      when "speed"
        format_speed(solve)
      when "moves"
        format_moves(solve)
      end
    end

    def format_speed(solve)
    end

    def format_moves(solve)
      ""
    end

    def delimiter
      delim = super
      if delim.blank?
        "//"
      else
        delim
      end
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
