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
  query_words = params.fetch("query", "").split(/[\s,]+/)
  @solves = RCDB::Solve.joined
  query_words.each do |word|
    if word =~ /^reconstructor:/
        @solves = @solves.where(
        Sequel.like(Sequel.function(:UPPER, :reconstructor_name), "%#{word.split(":")[1].upcase.tr("-", " ")}%")
      )
    else
      @solves = @solves.where(Sequel.|(
        Sequel.like(Sequel.function(:UPPER, :solver_name), "%#{word.upcase}%"),
        Sequel.like(Sequel.function(:UPPER, :competition_name), "%#{word.upcase}%"),
        Sequel.like(Sequel.function(:UPPER, :puzzle_name), "%#{word.upcase}%"),
        Sequel.like(Sequel.function(:UPPER, :single_record), "%#{word.upcase}%"),
        Sequel.like(Sequel.function(:UPPER, :average_record), "%#{word.upcase}%"),
        Sequel.like(Sequel.function(:UPPER, :time), "%#{word.upcase}%")
      ))
    end
  end
  @solves = @solves.order_by(Sequel.desc(:date_added))
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
