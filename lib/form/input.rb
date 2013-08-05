module ReconDatabase
  module Form
    class Input
      attr_reader :title, :default_specifier, :default_time

      def initialize(args)
        @title = args[:title]
        @default_specifier = args[:default_specifier]
        @default_time = args[:default_time]
      end

      def html
        ERB.new(File.read("views/input.erb")).result(binding)
      end
    end
  end
end
