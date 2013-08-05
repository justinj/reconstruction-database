require "sinatra"

require_relative "lib/database"
require_relative "lib/solve"
require_relative "helpers/view_helpers"
require_relative "lib/form/dropdown"
require_relative "lib/form/input"

get "/" do
  get_solves(params)
  get_fields(params)
  erb :index
end

get "/:id" do
  if params[:id] =~ /\d+/
    @solve = ReconDatabase::Solve.get(params[:id].to_i)
    erb :solve
  end
end

def get_solves(params)
  @solves = ReconDatabase::Solve.query(params)
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
