Sequel::Model.plugin :crushyform
Sequel::Model.plugin :json_serializer
Sequel::Model.db = Sequel.connect ENV["DB_URL"]
DB = Sequel::Model.db 
