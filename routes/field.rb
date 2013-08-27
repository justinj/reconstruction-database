[ReconDatabase::Solver, ReconDatabase::Competition, ReconDatabase::Puzzle].each do |field|
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
end
