require "sinatra"

require_relative "lib/solve"
require_relative "lib/solves"

get "/" do
  get_solves(params)
  @solvers = Solve.solvers
  erb :index
end

def get_solves(params)
  specified = params.has_key?("solver") && !params["solver"].empty?
  @solves = if specified
    Solve.by params["solver"]
  else
    Solve.all
  end

  @solver = specified ? params["solver"] : "Everyone"
end

get "/:id" do
  @solve = Solve.get(params[:id].to_i)
  erb :solve
end
