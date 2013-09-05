module RCDB
  describe Helpers do
    include Helpers
    it "escapes html" do
      Rack::Utils.expects(:escape_html).with("<br>")
      h("<br>")
    end
  end
end
