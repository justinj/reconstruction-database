module ReconDatabase
  module Helpers
    def current_user
      User.where(id: session[:user_id]).first
    end
  end
end
