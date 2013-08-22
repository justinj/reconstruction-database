get "/admin/:table" do
  table = params["table"].to_sym
  @dataset = DB[table]
  erb :admin_table
end

get "/admin/:table/edit/:id" do
  table = params["table"].to_sym
  id = params["id"]
  @entry = DB[table].find(id: id).first
  erb :admin_edit
end
