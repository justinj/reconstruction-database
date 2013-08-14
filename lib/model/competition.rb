module ReconDatabase
  class Competition < Sequel::Model
    one_to_many :solves, class: Solve

    def display_name
      name
    end

    class << self
      def queryer_html
        ERB.new(File.read("views/dropdown_x.erb")).result(binding)
      end

      def field_name
        "Competition"
      end

      def query_name
        field_name.downcase
      end

      def filter(dataset, params)
        competition = where(name: params["competition"]).first
        dataset.where(competition: competition)
      end
    end
  end
end
