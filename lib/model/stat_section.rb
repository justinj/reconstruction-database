module RCDB
  class StatSection < Sequel::Model
    many_to_one :solve
    one_to_many :stats

    def self.create_from_post_data(data, position)
      name = data.first
      values = data[1]
      time = values["TIME"]
      section = create(name: name,
                       position: position,
                       time: time
                      )
      ["ETM", "QTM", "STM"].select{ |metric| values.has_key?(metric) }.each do |metric|
        section.add_stat(amount: values[metric],
                         name: metric)
      end
      section
    end
    
    def before_destroy
      stats.each(&:destroy)
    end
  end
end
