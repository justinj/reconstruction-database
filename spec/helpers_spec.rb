module RCDB
  describe Helpers do
    include Helpers
    it "escapes html" do
      Rack::Utils.expects(:escape_html).with("<br>")
      h("<br>")
    end

    it "chomps solver names" do
      chomp("solver" => "Feliks ").must_equal "solver" => "Feliks"
    end
  end
end
