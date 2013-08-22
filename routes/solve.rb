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
