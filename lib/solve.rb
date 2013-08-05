module ReconDatabase class Solve
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
        simple_params = params.reject{ |field, s| s.empty? || !queryable_fields.include?(field) }.map { |k, v| [k.to_sym, v] }
        results = SolveDatabase.where(simple_params)
        results = filter_times(params, results)
        results.map { |result| new(Hash[result]) }
      end

      def filter_times(params, dataset)
        operation = params.fetch("time-specifier", "").to_sym
        valid_query = [:less, :greater, :equal].include?(operation)
        valid_query &&= params.fetch("time", 0.0).to_f != 0.0
        return dataset unless valid_query
        case operation
        when :less
          dataset.where{time < params.fetch("time")}
        when :greater
          dataset.where{time > params.fetch("time")}
        when :equal
          dataset.where(time: params.fetch("time"))
        end
      end
    end
  end
end
