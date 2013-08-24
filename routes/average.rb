get "/average" do
  authenticate!
  @averages = ReconDatabase::Average.all
  erb :average_index
end

get "/average/edit/:id" do
  authenticate!
  @average = ReconDatabase::Average.where(id: params["id"]).first
  erb :edit_average
end

get "/average/new" do
  authenticate!
  @average = ReconDatabase::Average.create
  redirect "/average/edit/#{@average.id}"
end

get "/average/delete/:id" do
  authenticate!
  @average = ReconDatabase::Average.where(id: params[:id]).first
  erb :delete_confirm
end

get "/average/delete_confirm/:id" do
  authenticate!
  @average = ReconDatabase::Average.where(id: params[:id]).destroy
  redirect "/average"
end

post "/average/update/:id" do
  authenticate!
  id = params.delete("id")
  ReconDatabase::Average.where(id: id).update(params["average"])
  redirect "/average"
end
