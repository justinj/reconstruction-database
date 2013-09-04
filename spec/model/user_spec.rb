module RCDB
  describe User do
    before do
      @admin = User.create(name: "admin", password: "password", root: true)
      @notroot = User.create(name: "not_root", password: "password", root: false)
    end

    after do
      destroy_db
    end

    let(:admin) { @admin }
    let(:notroot) { @notroot }

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

    describe "root" do
      it "is root if the column is set" do
        admin.must_be :root?
        notroot.wont_be :root?
      end
    end
  end
end
