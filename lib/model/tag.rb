module RCDB
  class Tag < Sequel::Model
    many_to_many :solves, class: Solve, left_key: :tag_id, right_key: :solve_id
    many_to_many :averages, class: Average, left_key: :tag_id, right_key: :average_id

    class << self
      def queryer_html(params)
        ERB.new(File.read("views/tag_input.erb")).result(binding)
      end

      def filter_solves(dataset, params)
        tags = params["tags"].to_s.split(/\s+/).map do |tag_name|
          first(name: tag_name)
        end.compact.map(&:id)

        solves_with_average_tags = DB[:averages_tags].join(:solves, average_id: :average_id).select(:id, :tag_id)

        solves_tags = DB[:solves_tags].union(solves_with_average_tags)
        solves_tags = solves_tags.where(tag_id: tags)

        tags.inject(dataset) do |dataset, tag|
          valid_solves = solves_tags.where(tag_id: tag).select(:solve_id)
          dataset.where(id: valid_solves)
        end
      end
    end
  end
end
