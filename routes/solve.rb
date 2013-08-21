get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

get "/solve/submission" do
  erb :edit_solve
end
