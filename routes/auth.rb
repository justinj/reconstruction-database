get "/login" do
  erb :login
end

get "/logout" do
  session[:user_id] = nil
  flash[:success] = "Succesfully logged out."
  redirect "/"
end

post "/authenticate" do
  user = RCDB::User.authenticate(params)
  if user
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in."
    redirect "/average"
  else
    flash[:danger] = "Failed to log in."
    redirect "/login"
  end
end
