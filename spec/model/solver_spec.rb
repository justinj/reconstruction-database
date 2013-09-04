module RCDB
  describe Solver do
    describe "#to_s" do
      it "is its name" do
        Solver.new(name: "John").to_s.must_equal "John"
      end
    end
  end
end
