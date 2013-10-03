require "dotenv"
require "sequel"

# Create the .env file to point to the database

if File.exist?(".env")
  puts ".env file already exists, skipping creating it..."
else
  File.write(".env", "DB_URL=sqlite://db.sqlite")
end

Dotenv.load

`rake migrate`

require_relative "../lib/database"
require_relative "../lib/recondb"

include RCDB

# Set up some sample data

average = Average.create(solver: "Justin Jaffray",
                         visible: true,
                         competition: "Justin's House Open 2013", puzzle: "3x3")
%w(10.00 11.00 12.00 13.00 14.00).each do |time|
  average.add_solve(Solve.create(time: time,
                                 scramble: "U R U' R'",
                                 solution: "R U R' U' // solution",
                                 youtube: "ygr5AHufBN4"))
end

User.create(name: "admin", password: "password")
