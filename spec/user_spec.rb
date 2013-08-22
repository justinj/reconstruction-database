require_relative "spec_helper"

module ReconDatabase
  describe User do
    before do
      User.create(name: "admin", password: "password")
    end

    def auth(name, pw)
      User.authenticate("username" => name, "password" => pw)
    end

    it "authenticates from params" do
      user = auth("admin", "password")
      user.name.must_equal "admin"
    end

    it "doesn't give out the password" do
      user = auth("admin", "password")
      user.password.wont_equal "password"
    end

    describe "unsuccessful login" do
      it "returns nil if the password didn't match" do
        user = auth("admin", "not-password")
        user.must_be_nil
      end

      it "returns nil if the user didn't exist" do
        user = auth("tomfoolery", "not-password")
        user.must_be_nil
      end
    end
  end
end
