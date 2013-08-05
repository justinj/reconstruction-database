require "sequel"

module ReconDatabase
  class SolveDatabase
    class << self

      def add(solve)
        solves.insert solve
      end

      def all
        solves.all
      end

      def where(params)
        solves.where(params)
      end

      def every(field)
        solves.select(field).distinct.map { |hsh| hsh[field] }
      end

      def test
        @db = testing_db
      end

      private

      def solves
        add_solves_table unless db.table_exists? :solves
        db[:solves]
      end

      def add_solves_table
        db.create_table :solves do
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

      def db
        @db ||= Sequel.sqlite "./db/db.sqlite"
      end

      def testing_db
        Sequel.sqlite
      end
    end
  end
end
