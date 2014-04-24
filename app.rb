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
  unless params["query"].blank?
    DB[:queries].insert(
      timestamp: Time.now.utc.to_i,
      query: params["query"],
      ip_hash: Digest::SHA1.hexdigest(request.ip)
    )
  end
  @solves = RCDB::Solve.joined
  query = RCDB::QueryParser.parse(params.fetch("query", ""))
  @solves = RCDB::QueryParser.query_dataset(query, @solves)
  erb :index
end

# HACK...
get "/stats" do
  authenticate!
  erb :search_stats, locals: { searches: DB[:queries] }
end

not_found do
  redirect "/"
end
