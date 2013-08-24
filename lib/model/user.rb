module ReconDatabase
  class User < Sequel::Model
    def initialize(args={})
      args[:password] = User.encrypt(args[:password])
      super
    end

    def root?
      name == "admin"
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
