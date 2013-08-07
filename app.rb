require "sinatra"
require "sequel"
require_relative "lib/database"
require_relative "lib/solve"
require_relative "helpers/view_helpers"
require_relative "lib/form/dropdown"
require_relative "lib/form/input"

helpers ReconDatabase::ViewHelpers

get "/" do
  get_solves(params)
  get_fields(params)
  erb :index
end

get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

def get_solves(params)
  @solves = ReconDatabase::Solve.request(params)
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
