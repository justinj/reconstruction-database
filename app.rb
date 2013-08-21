require "sinatra"
require "dotenv"
Dotenv.load

require_relative "lib/recondb"
require_relative "routes/average"
require_relative "routes/solve"
require_relative "routes/admin"

helpers ReconDatabase::ViewHelpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).sort_by { |s| -s[:date_added].to_i}
  erb :index
end

