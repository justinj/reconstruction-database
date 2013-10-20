module RCDB
  describe ViewHelpers do
    include RCDB::ViewHelpers
    it "formats the date of a solve" do
      date = Date.new(2010,8,10)
      date_added(stub(date_added: date)).must_equal "Aug 10, 2010"
    end

    describe "pagination" do
      let(:dataset) { mock }
      let(:params) { {} }
      it "defaults to the first page and 100 entries" do
        dataset.expects(:paginate).with(1, 100)
        paginate(dataset)
      end

      it "reads the `params`" do
        params["page"] = "2"
        dataset.expects(:paginate).with(2, 100)
        paginate(dataset)
      end
    end
  end
end
