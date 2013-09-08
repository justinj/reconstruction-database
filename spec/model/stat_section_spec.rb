module RCDB
  describe StatSection do
    describe "create_from_post_data" do
      it "creates new stats with the data" do
        StatSection.any_instance.expects(:add_stat)
          .with(amount: 10,
                name: "ETM")
        StatSection.create_from_post_data(["Total", { 
          "TIME" => 10.00,
          "ETM" => 10}], 0)
      end
    end
  end
end
