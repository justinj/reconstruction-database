Sequel::Model.plugin :crushyform
Sequel::Model.plugin :json_serializer
Sequel::Model.db = Sequel.sqlite "db/db.sqlite"
