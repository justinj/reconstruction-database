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
require_relative "routes/contributors"

use Rack::Session::Cookie, secret: ENV.fetch("SECRET") { "Hidden!" }
use Rack::Flash

helpers RCDB::ViewHelpers
helpers RCDB::Helpers
helpers RCDB::FormattingUtils
helpers Padrino::Helpers

get "/" do
  @solves = RCDB::Solve.request(params).order_by(Sequel.desc(:date_added))
  @was_search = params.reject { |k,v| v.blank? }.any?
  erb :index
end

not_found do
  redirect "/"
end
