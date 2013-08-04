require "sinatra"

require_relative "lib/solves"
require_relative "lib/database"
require_relative "lib/solve"
ReconDatabase::SolveDatabase.init



get "/" do
  get_solves(params)
  get_fields(params)
  erb :index
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.get(params[:id].to_i)
  erb :solve
end

def get_solves(params)
  @solves = ReconDatabase::Solve.query(params)
end

def get_fields(params)
  @fields = ReconDatabase::Solve.queryable_fields.map do |field|
    {
      name: field,
      all_values: ReconDatabase::Solve.possible_values_for(field),
      default_value: params[field]
    }
  end
end
