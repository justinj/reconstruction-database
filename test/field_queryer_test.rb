module ReconDatabase
  module Form
    class DropdownTest < Minitest::Test
      attr_reader :dropdown

      def setup
        @dropdown = Dropdown.new(title: "Solver",
                                 type: :dropdown,
                                 potential_values: ["Dan Cohen", "Ansii Vanhala"])
      end

      def test_title
        assert_equal "Solver", dropdown.title
      end
    end
  end
end
