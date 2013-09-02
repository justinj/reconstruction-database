module RCDB
  module Taggable
    def tag(tag_name)
      t = Tag.find_or_create(name: tag_name)
      add_tag(t) unless tags.include? t
    end

    def tags=(tags_to_add)
      remove_all_tags
      tags_to_add.split("\n").map(&:chomp).each { |t| tag(t) }
    end
  end
end
