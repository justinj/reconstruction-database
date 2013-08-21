require "sinatra"
require "dotenv"
Dotenv.load

require_relative "lib/recondb"

use Rack::Session::Cookie, secret: ENV["SECRET_KEY"]

helpers ReconDatabase::ViewHelpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).sort_by { |s| -s[:date_added].to_i}
  p ENV["SECRET_KEY"]
  erb :index
end

get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

get "/average/edit/:id" do
  @average = ReconDatabase::Average.find(id: params[:id])
  erb :edit_average
end

get "/solve/new/:average_id" do
  average_id = params["average_id"]
  ReconDatabase::Solve.create(average_id: average_id)
  redirect "/average/edit/#{average_id}"
end

get "/solve/delete/:solve_id" do
  id = params["solve_id"]
  average_id = ReconDatabase::Solve.find(id: id).average_id
  ReconDatabase::Solve.where(id: id).delete
  redirect "/average/edit/#{average_id}"
end

get "/solve/edit/:id" do
  @solve = ReconDatabase::Solve.find(id: params[:id])
  erb :edit_solve
end

post "/solve/update/:id" do
  id = params["id"]
  solve = ReconDatabase::Solve.find(id: id)
  solve.update(params["solve"])
  redirect "/solve/#{id}"
end
