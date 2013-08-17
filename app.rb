require "sinatra"

require_relative "lib/recondb"

helpers ReconDatabase::ViewHelpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).sort_by { |s| -s[:date_added].to_i}
  erb :index
end

get "/solve" do
  redirect "/"
end

get "/solve/:id" do
  @solve = ReconDatabase::Solve.where(id: params[:id]).first
  erb :solve
end

get "/brest_post" do
  erb :post_submission
end

post "/new_post" do
  @solves = ReconDatabase::BrestParser.new(params["post-content"]).solves
  erb :submission_form
end

get "/new_post" do
  @solves = [{}]
  erb :submission_form
end

post "/submit" do
  params.to_yaml.to_s.gsub("\n", "<br>")
end
