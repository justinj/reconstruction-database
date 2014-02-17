describe "Adding a new Brest solve" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    destroy_db
    RCDB::User.create(name: "admin", password: "password")
    post "/authenticate", username: "admin", password: "password"
  end

  after do
    destroy_db
  end

  it "adds it as a solve" do
    RCDB::Solve.count.must_equal 0

    post_content = File.read("spec/fixtures/feliks_588_wc_2013")
    post "/average/submit_brest_post", 
      :"submission[content]" => post_content,
      :"submission[reconstructor]" => "Brest"

    RCDB::Solve.count.must_equal 1

    solve = RCDB::Solve.first

    solve.steps.count.must_equal 8
    solve.steps[1].moves.must_equal "R D R D R'"
  end
end
