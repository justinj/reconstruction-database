[RCDB::Solver, RCDB::Competition, RCDB::Puzzle].each do |field|
  get "/#{field.query_name}" do
    authenticate!
    @model = field
    erb :enumerate_field
  end

  get "/#{field.query_name}/edit/:id" do
    authenticate!
    @entry = field.first(id: params[:id])
    erb :edit_field
  end

  post "/#{field.query_name}/update/:id" do
    authenticate!
    field.where(id: params[:id]).update(params["entry"])
    redirect "/#{field.query_name}"
  end

  get "/#{field.query_name}/delete/:id" do
    authenticate!
    @entry = field.first(id: params[:id])
    @delete_url = "/#{field.query_name}/delete_confirm"
    erb :delete_confirm
  end

  get "/#{field.query_name}/delete_confirm/:id" do
    authenticate!
    @entry = field.first(id: params[:id])
    @entry.destroy
    redirect "/#{field.query_name}"
  end
end
