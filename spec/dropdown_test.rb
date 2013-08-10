module ReconDatabase
  module Form
    describe Dropdown do
      attr_reader :dropdown

      before do
        @dropdown = Dropdown.new(title: "Solver",
                                 type: :dropdown,
                                 potential_values: ["Dan Cohen", "Ansii Vanhala"])
      end

      it "has the title" do
        dropdown.title.must_equal "Solver"
      end
    end
  end
end
