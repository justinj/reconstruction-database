module RCDB
  class User < Sequel::Model
    def password=(val)
      super(User.encrypt(val))
    end

    def root?
      root == 1
    end

    def self.authenticate(args)
      name = args["username"]
      pw = encrypt(args["password"])
      user = find(name: name)
      if user && user.password == pw
        user
      end
    end

    def self.encrypt(pass)
      Digest::SHA1.hexdigest(pass)
    end
  end
end
