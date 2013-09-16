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

    def garronizable?
      name =~ /\dx\d/
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
