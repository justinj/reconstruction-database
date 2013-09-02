module RCDB
  class Tag < Sequel::Model
    many_to_many :solves, class: Solve, left_key: :tag_id, right_key: :solve_id
    many_to_many :averages, class: Average, left_key: :tag_id, right_key: :average_id

    class << self
      def queryer_html(params)
        ERB.new(File.read("views/tag_input.erb")).result(binding)
      end

      def filter_solves(dataset, params)
        tags = params["tags"].to_s.split(/s+/).map do |tag_name|
          first(name: tag_name)
        end.compact

        valid_solves = tags.inject(Solve) do |ds, tag|
          ds.where(tags: tag)
        end.map(&:id)

        valid_averages = tags.inject(Average) do |ds, tag|
          ds.where(tags: tag)
        end.map(&:id)

        dataset.where(id: valid_solves).or(average_id: valid_averages)
      end
    end
  end
end
