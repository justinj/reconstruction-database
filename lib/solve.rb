module ReconDatabase
  class Solve
    attr_accessor :solver, 
      :scramble, 
      :solution, 
      :time, 
      :youtube,
      :competition,
      :id,
      :puzzle

    def initialize(args)
      args.each do |field, value|
        send((field.to_s + "=").to_sym, value)
      end
    end

    def inspect
      "#@time:#@solver"
    end

    class << self
      def all
        SolveDatabase.all
      end

      def add(solve)
        SolveDatabase.add(solve)
      end

      def get(id)
        new(SolveDatabase.where(id: id).first)
      end

      def possible_values_for(field)
        SolveDatabase.every(field)
      end

      def queryable_fields
        %i(solver puzzle competition)
      end

      def query(params)
        params = params.reject{ |_, s| s.empty? }.map { |k, v| [k.to_sym, v] }
        hashes_returned = SolveDatabase.where(params)
        hashes_returned.map { |result| new(Hash[result]) }
      end

      def delete_all
        SolveDatabase.clear
      end
    end
  end
end
