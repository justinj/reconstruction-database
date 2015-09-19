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
  get_solve(params["id"])
end

get %r{^/(\d+)$} do
  get_solve(params[:captures].first)
end

def get_solve(id)
  @solve = RCDB::Solve.first(id: id)
  if @solve
    erb :solve
  else
    not_found
  end
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
  @entry = RCDB::Solve.where(id: params[:id]).first
  @delete_url = "/solve/delete_confirm"
  erb :delete_confirm
end

post "/solve/delete_confirm/:id" do
  authenticate!
  RCDB::Solve.where(id: params[:id]).destroy
  redirect "/average"
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
  params["model"] = chomp(params["model"])
  @solve.update(params["model"])
  redirect request.referrer
end
