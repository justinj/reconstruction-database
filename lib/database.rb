Sequel::Model.plugin :crushyform
Sequel::Model.plugin :json_serializer

unless ENV["RACK_ENV"] == "test"
  Sequel::Model.db = Sequel.connect ENV["DB_URL"]
  DB = Sequel::Model.db
end
DB.extension(:pagination)
