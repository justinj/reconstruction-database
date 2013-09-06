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

use Rack::Session::Cookie, secret: ENV.fetch("SECRET") { "Hidden!" }
use Rack::Flash

helpers RCDB::ViewHelpers
helpers RCDB::Helpers
helpers RCDB::FormattingUtils

get "/" do
  @solves = RCDB::Solve.request(params).order_by(Sequel.desc(:date_added))
  erb :index
end

not_found do
  redirect "/"
end
