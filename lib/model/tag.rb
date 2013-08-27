module RCDB
  class Tag < Sequel::Model
    many_to_many :solves, class: Solve, left_key: :tag_id, right_key: :solve_id

    class << self
      def queryer_html(params)
        ERB.new(File.read("views/tag_input.erb")).result(binding)
      end

      def filter_solves(dataset, params)
        tags = params["tags"].to_s.split(" ").map do |tag_name|
          first(name: tag_name)
        end.compact

        tags.inject(dataset) do |ds, tag|
          ds.where(tags: tag)
        end
      end
    end
  end
end
