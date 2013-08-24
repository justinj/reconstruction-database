module ReconDatabase
  module Helpers
    def current_user
      User.where(id: session[:user_id]).first
    end

    def authenticate!
      unless current_user
        redirect "/"
      end
    end

    def authenticate_root!
      unless current_user && current_user.root?
        redirect "/"
      end
    end
  end
end
