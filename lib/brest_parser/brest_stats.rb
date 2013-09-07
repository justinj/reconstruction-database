module RCDB
  class BrestStats
    attr_reader :total_time

    def self.parse(input)
      plain_input = remove_bbcode(input)
      field_lists = field_listify(plain_input)
      build_result(field_lists)
    end

    private

    def self.build_result(field_lists)
      headers = field_lists.shift
      valid_lines = field_lists.reject { |(first_entry)| valid_entry?(first_entry) }
      valid_lines.each_with_object({}) do |line, result|
        add_entry(result, line, headers)
      end
    end

    def self.valid_entry?(entry)
      entry.empty?
    end

    def self.add_entry(hash, line, headers)
      with_header = headers.zip(line)
      title = with_header.shift.last
      hash[title] = Hash[with_header.map { |k, v| [k, v.to_f] }]
    end

    def self.remove_bbcode(input)
      input.gsub(/\[.*?\]/, "")
    end

    def self.field_listify(line)
      line.lines.map { |line| line.split(/\s+/) }
    end
  end
end
