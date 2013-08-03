require "sinatra"

require_relative "lib/solve"
require_relative "lib/solves"

get "/" do
  get_solves(params)
  get_fields(params)
  erb :site do
    erb :index
  end
end

def get_solves(params)
  @solves = Solve.matching(params)
end

def get_fields(params)
  @fields = Solve.queryable_fields.map do |field|
    {
      name: field,
      all_values: Solve.values_for_field(field),
      default_value: params[field]
    }
  end
end

get "/solve/:id" do
  @solve = Solve.get(params[:id].to_i)
  erb :site do
    erb :solve
  end
end
