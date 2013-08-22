get "/login" do
  erb :login
end

get "/logout" do
  session[:user_id] = nil
  "Logged out"
end

post "/authenticate" do
  user = ReconDatabase::User.authenticate(params)
  if user
    session[:user_id] = user.id
    "Successfully logged in."
  else
    "Failed to log in."
  end
end
