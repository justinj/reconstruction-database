get "/average" do
  authenticate!
  @averages = RCDB::Average.all
  erb :average_index
end

get "/average/edit/:id" do
  authenticate!
  @average = RCDB::Average.where(id: params["id"]).first
  erb :edit_average
end

get "/average/new" do
  authenticate!
  @average = RCDB::Average.create
  redirect "/average/edit/#{@average.id}"
end

get "/average/new_from_brest" do
  authenticate!
  erb :new_from_brest
end

post "/average/submit_brest_post" do
  authenticate!
  parser = RCDB::BrestParser.new(params["submission"]["reconstructor"],
                                 params["submission"]["content"])
  average = RCDB::Average.create(solver: parser.solver,
                                  competition: parser.competition,
                                  puzzle: parser.puzzle)

  parser.solves.each { |solve| average.add_solve(solve) }
  redirect "/average/edit/#{average.id}"
end

get "/average/delete/:id" do
  authenticate!
  @entry = RCDB::Average.where(id: params[:id]).first
  @delete_url = "/average/delete_confirm"
  erb :delete_confirm
end

post "/average/delete_confirm/:id" do
  authenticate!
  @average = RCDB::Average.first(id: params[:id])
  @average.destroy
  redirect "/average"
end

post "/average/update/:id" do
  authenticate!
  id = params.delete("id")
  params["model"] = chomp(params["model"])
  RCDB::Average.first(id: id).update(params["model"])
  redirect request.referrer
end
