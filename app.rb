require "sinatra"

require_relative "lib/solve"
require_relative "lib/solves"

get "/" do
  @solves = Solve.all
  erb :index
end

get "/:id" do
  @solve = Solve.get(params[:id].to_i)
  erb :solve
end
