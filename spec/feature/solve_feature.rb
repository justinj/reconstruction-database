module RCDB
  describe "solve features" do
    include Rack::Test::Methods

    def app
      Sinatra::Application
    end

    describe "when authenticated" do
      before do
        User.stubs(:first).returns(User.new)
      end

      describe "/solve/new/:average_id" do
        it "creates a new solve for the average" do
          Solve.expects(:create).with(average_id: '1')
          get "/solve/new/1"
        end
      end
    end

    describe "when not authenticated" do
      before do
        User.stubs(:first).returns(nil)
      end

      describe "/solve/new/:average_id" do
        it "doesn't log do anything" do
          Solve.expects(:create).with(average_id: '1').never
          get "/solve/new/1"
        end
      end
    end
  end
end
