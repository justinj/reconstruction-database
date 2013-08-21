# get "/solve/new/:average_id" do
#   average_id = params["average_id"]
#   ReconDatabase::Solve.create(average_id: average_id)
#   redirect "/average/edit/#{average_id}"
# end

# get "/solve/delete/:solve_id" do
#   id = params["solve_id"]
#   average_id = ReconDatabase::Solve.find(id: id).average_id
#   ReconDatabase::Solve.where(id: id).delete
#   redirect "/average/edit/#{average_id}"
# end

# get "/solve/edit/:id" do
#   @solve = ReconDatabase::Solve.find(id: params[:id])
#   erb :edit_solve
# end

# post "/solve/update/:id" do
#   id = params["id"]
#   solve = ReconDatabase::Solve.find(id: id)
#   solve.update(params["solve"])
#   redirect "/solve/#{id}"
# end

# get "/average" do
#   @averages = ReconDatabase::Average.sort_by { |average| -average.id }
#   erb :average_index
# end

# get "/average/edit/:id" do
#   @average = ReconDatabase::Average.find(id: params[:id])
#   erb :edit_average
# end

# get  "/average/new" do
#   average = ReconDatabase::Average.create
#   redirect "/average/edit/#{average.id}"
# end

# get  "/average/delete/:average_id" do
#   id = params["average_id"]
#   ReconDatabase::Average.where(id: id).delete
#   redirect "/average"
# end

# post "/average/update/:average_id" do
#   id = params["average_id"]
#   solve = ReconDatabase::Average.find(id: id)
#   solve.update(params["average"])
#   redirect "/average/edit/#{id}"
# end
