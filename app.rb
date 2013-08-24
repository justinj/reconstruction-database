require "sinatra"
require "dotenv"
require "logger"
require "fileutils"
require "sequel"

Dotenv.load

require_relative "lib/database"


require_relative "lib/recondb"
require_relative "routes/average"
require_relative "routes/solve"
require_relative "routes/admin"
require_relative "routes/auth"

use Rack::Session::Cookie, secret: ENV["SECRET"]

helpers ReconDatabase::ViewHelpers
helpers ReconDatabase::Helpers

get "/" do
  @solves = ReconDatabase::Solve.request(params).sort_by { |s| -s[:date_added].to_i}
  erb :index
end
