get "/solve" do
  redirect "/"
end

get "/solve/brest_submit" do
  erb :solve_submission
end

post "/solve/brest_parse" do
  result = RCDB::BrestParser.new(params["post_content"]).solves
  @result = result
  erb :brest_parse
end

get "/solve/:id" do
  @solve = RCDB::Solve.first(id: params[:id])
  erb :solve
end

### authentication required

get "/solve/new/:average_id" do
  authenticate!
  id = params[:average_id]
  RCDB::Solve.create(average_id: id)
  redirect request.referrer
end

get "/solve/delete/:id" do
  authenticate!
  id = params[:id]
  RCDB::Solve.where(id: id).delete
  redirect request.referrer
end

get "/solve/edit/:id" do
  authenticate!
  @solve = RCDB::Solve.first(id: params["id"])
  erb :edit_solve
end

post "/solve/update/:id" do
  authenticate!
  id = params["id"]
  @solve = RCDB::Solve.first(id: id)
  @solve.update(params["solve"])
  redirect "/solve/#{id}"
end
