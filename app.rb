require "sinatra"

require_relative "lib/recondb"

helpers ReconDatabase::ViewHelpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).order(Sequel.desc(:date_added))
  erb :index
end

get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end
