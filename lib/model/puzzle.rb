module RCDB
  class Puzzle < Sequel::Model
    extend Field
    one_to_many :averages

    def initialize(args={})
      args["formatting_type"] ||= "speed"
      super
    end

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

	def roofpigable?
	  name == "3x3"
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
