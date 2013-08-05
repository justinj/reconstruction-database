module ReconDatabase
  module Form
    class Dropdown
      attr_reader :title, :potential_values, :default_value

      def initialize(args)
        @title = args[:title]
        @potential_values = args[:potential_values]
        @default_value = args[:default_value]
      end

      def html
        ERB.new(File.read("views/dropdown.erb")).result(binding)
      end
    end
  end
end
