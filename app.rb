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

FileUtils.mkdir "logs" unless File.exist? "logs"
$LOGGER = Logger.new("logs/log", "weekly")

get "/callback" do
  $LOGGER.info params.to_s
end

get "/auth" do
  @callback_url = "http://www.rcdb.justinjaffray.com/callback"
  @consumer = OAuth::Consumer.new(ENV["GOOGLE_OAUTH_CLIENT"],
                                  ENV["GOOGLE_OAUTH_SECRET"],
                                  :site => "http://www.rcdb.justinjaffray.com")
  @request_token = @consumer.get_request_token(:oauth_callback => @callback_url)
  session[:request_token] = @request_token
  redirect_to @request_token.authorize_url(:oauth_callback => @callback_url)
end

get "/dir" do
  FileUtils.pwd
end
