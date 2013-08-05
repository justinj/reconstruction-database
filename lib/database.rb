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
        params = symbolize_keys(params)
        result = solves.where(static_filters(params))
        result = filter_times(result, params)
        result.entries
      end

      def every(field)
        solves.select(field).distinct.map { |hsh| hsh[field] }
      end

      def test
        @db = testing_db
      end

      private

      def filter_times(result, params)
        specifier = params.fetch(:"time-specifier", "")
        time = params.fetch(:"time-value", "")
        if specifier.empty? || time.empty?
          result
        else
          result.where("? #{sign_for(specifier)} ?", :time, time)
        end
      end

      def sign_for(comparison)
        case comparison
        when "less"
          "<"
        when "greater"
          ">"
        when "equal"
          "="
        else
          raise "bad comparison"
        end
      end

      def static_filters(filters)
        remove_blanks(filters).select { |k, v| static_fields.include? k }
      end

      def symbolize_keys(hash)
        Hash[hash.map{ |k,v| [k.to_sym, v]}]
      end

      def static_fields
        %i(solver puzzle competition)
      end

      def remove_blanks(filters)
        filters.reject { |_, v| v.nil? || v == "" }
      end

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
