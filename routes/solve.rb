get "/solve" do
  redirect "/"
end

get "/solve/brest_submit" do
  erb :solve_submission
end

post "/solve/brest_parse" do
  result = ReconDatabase::BrestParser.new(params["post_content"]).solves
  @result = result
  erb :brest_parse
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

### authentication required

get "/solve/new/:average_id" do
  authenticate!
  id = params[:average_id]
  ReconDatabase::Solve.create(average_id: id)
  redirect request.referrer
end

get "/solve/delete/:id" do
  authenticate!
  id = params[:id]
  ReconDatabase::Solve.where(id: id).delete
  redirect request.referrer
end

get "/solve/edit/:id" do
  authenticate!
  @solve = ReconDatabase::Solve.where(id: params["id"]).first
  erb :edit_solve
end

post "/solve/update/:id" do
  authenticate!
  id = params["id"]
  @solve = ReconDatabase::Solve.where(id: id).first
  @solve.update(params["solve"])
  redirect "/solve/#{id}"
end
