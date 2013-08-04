require "sequel"

module ReconDatabase
  class SolveDatabase
    class << self

      def init
        @db = Sequel.sqlite "./db.sqlite"

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

          @solves = @db[:solves]
          ReconDatabase::SeedData.seed_database

        end
          @solves = @db[:solves]
      end

      def add(solve)
        @solves.insert solve
      end

      def all
        @solves.all
      end

      def where(params)
        @solves.where(params)
      end

      def every(field)
        @solves.all.map { |solve| solve[field] }.uniq.reject(&:nil?)
      end
    end
  end
end
