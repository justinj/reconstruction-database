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
  # only check searches for non-logged in users which are actually searches
  if params.has_key?("solver") && current_user.nil?
    DB[:searches].insert(
      timestamp: Time.now.utc.to_i,
      solver: params["solver"],
      competition: params["competition"],
      puzzle: params["puzzle"],
      time_specifier: params["time_specifier"],
      time_value: params["time_value"],
      tags: params["tags"],
      ip_hash: Digest::SHA1.hexdigest(request.ip)
    )
  end
  @solves = RCDB::Solve.request(params).order_by(Sequel.desc(:date_added))
  erb :index
end

# HACK...
get "/stats" do
  authenticate!
  erb :search_stats, locals: { searches: DB[:searches] }
end

not_found do
  redirect "/"
end
