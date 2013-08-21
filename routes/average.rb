get "/average" do
  @averages = ReconDatabase::Average.all
  erb :average_index
end

get "/average/edit/:id" do
  @average = ReconDatabase::Average.find(id: params[:id])
  erb :edit_average
end

get  "/average/new" do
  average = ReconDatabase::Average.create
  redirect "/average/edit/#{average.id}"
end

get  "/average/delete/:average_id" do
  id = params["average_id"]
  ReconDatabase::Average.where(id: id).delete
  redirect "/average"
end

