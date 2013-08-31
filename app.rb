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
require_relative "routes/field"
require_relative "routes/auth"

use Rack::Session::Cookie, secret: ENV["SECRET"]

helpers RCDB::ViewHelpers
helpers RCDB::Helpers
helpers RCDB::FormattingUtils

get "/" do
  @solves = RCDB::Solve.request(params).sort_by { |s| -s[:date_added].to_i}
  erb :index
end

not_found do
  redirect "/"
end
