module RCDB
  module Helpers
    def current_user
      User.first(id: session[:user_id])
    end

    def h(text)
      Rack::Utils.escape_html(text)
    end
    alias_method :escape_html, :h

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
