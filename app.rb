require "sinatra"

require_relative "lib/recondb"

helpers ReconDatabase::ViewHelpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).order(Sequel.desc(:date_added))
  get_fields(params)
  erb :index
end

get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  p params
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

def get_fields(params)
  @fields = ReconDatabase::Solve.queryable_fields.map do |field|
    ReconDatabase::Form::Dropdown.new({
      title: field,
      potential_values: ReconDatabase::Solve.possible_values_for(field),
      default_value: params[field]
    })
  end
  @fields << ReconDatabase::Form::Input.new({
    title: "Time",
    default_specifier: params["time-specifier"],
    default_time: params["time-value"]
  })
end
