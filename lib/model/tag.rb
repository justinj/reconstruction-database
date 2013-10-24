module RCDB
  class Tag < Sequel::Model
    extend Queryable
    many_to_many :solves, class: Solve, left_key: :tag_id, right_key: :solve_id
    many_to_many :averages, class: Average, left_key: :tag_id, right_key: :average_id

    def name=(value)
      super(value.downcase)
    end

    class << self
      def queryer_html(params)
        ERB.new(File.read("views/tag_input.erb")).result(binding)
      end

      def filter_solves(dataset, params)
        tags = extract_tags(params)
        solves_tags = full_solves_tags_table(tags)

        tags.inject(dataset) do |dataset, tag|
          valid_solves = solves_tags.where(tag_id: tag).select(:solve_id)
          dataset.where(id: valid_solves)
        end
      end

      private

      def extract_tags(query_params)
        query_params["tags"].to_s.split(/\s+/).map do |tag_name|
          first(name: tag_name.downcase) || nil
        end.map { |tag| tag ? tag.id : -1 }
      end

      # We need to combine the table with average tags and solve tags to get
      # the true table for tags
      def full_solves_tags_table(tags)
        solves_with_average_tags = DB[:averages_tags].join(:solves, average_id: :average_id).select(:id, :tag_id)

        solves_tags = DB[:solves_tags].union(solves_with_average_tags).where(tag_id: tags)
      end
    end
  end
end
