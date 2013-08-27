module RCDB
  describe Solver do
    describe "name link" do
      it "generates a link to the wca page when there's a wca id" do
        Solver.new(name: "John Doe", wca_id: "2013DOEJ01").name_link
        .must_equal "<a href='https://www.worldcubeassociation.org/results/p.php?i=2013DOEJ01' target='_blank'>John Doe</a>"
      end

      it "doesn't have a link if there's no wca id" do
        Solver.new(name: "John Doe", wca_id: nil).name_link
        .must_equal "John Doe"
      end
    end
  end
end
