require "sequel"

module ReconDatabase
  class SolveDatabase
    class << self

      def init
        @db = get_db

        unless @db.table_exists? :solves
          @db.create_table :solves do
            primary_key :id
            String :scramble
            String :solution
            String :solver
            Float :time

            String :youtube
            String :competition
            String :puzzle
          end
        end
        @solves = @db[:solves]
      end

      def clear
        init
        @db.drop_table :solves
      end

      def add(solve)
        init
        @solves.insert solve
      end

      def all
        init
        @solves.all
      end

      def where(params)
        init
        @solves.where(params)
      end

      def every(field)
        init
        @solves.select(field).distinct.map { |hsh| hsh[field] }
      end

      def test
        @testing = true
      end

      private

      def get_db
        if @testing
          Sequel.sqlite "./testdb"
        else
          Sequel.sqlite "./db/db.sqlite"
        end
      end
    end
  end
end
