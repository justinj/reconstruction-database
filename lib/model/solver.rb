module ReconDatabase
  class Solver < Sequel::Model
    one_to_many :solves, class: Solve

    def display_name
      name
    end

    class << self
      def queryer_html
        ERB.new(File.read("views/dropdown_x.erb")).result(binding)
      end

      def field_name
        "Solver"
      end

      def query_name
        field_name.downcase
      end

      def filter(dataset, params)
        solver = where(name: params["solver"]).first
        dataset.where(solver: solver)
      end
    end
  end
end
