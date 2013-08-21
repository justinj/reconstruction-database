Sequel::Model.plugin :crushyform
Sequel::Model.plugin :json_serializer
Sequel::Model.db = Sequel.sqlite "db/db.sqlite"
DB = Sequel::Model.db 

require "sinatra-authentication"
