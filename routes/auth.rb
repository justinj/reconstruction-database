get "/login" do
  erb :login
end

get "/logout" do
  session[:user_id] = nil
  redirect "/"
end

post "/authenticate" do
  user = RCDB::User.authenticate(params)
  if user
    session[:user_id] = user.id
    redirect "/"
  else
    redirect "/login?failure=true"
  end
end
