module RCDB
  module QueryParser
    def self.parse str
      {
        tokens: str.split(/[\s,]+/).reject { |token| token =~ /:/ },
        reconstructors: extract_reconstructors(str)
      }
    end

    def self.query_dataset(parsed, dataset)
      parsed[:tokens].each do |token|
        dataset = dataset.where(Sequel.|(
          matches(token, :solver_name),
          matches(token, :competition_name),
          matches(token, :puzzle_name),
          matches(token, :single_record),
          matches(token, :average_record),
          matches(token, :time),
        ))
      end

      parsed[:reconstructors].each do |reconstructor|
        dataset = dataset.where(Sequel.|(
          matches(reconstructor, :reconstructor_name),
        ))
      end

      dataset.order_by(Sequel.desc(:date_added))
    end

    private

    def self.extract_reconstructors(str)
      str.scan(/reconstructor:[\w-]+/)
        .map { |r| r.split(":", 2).last }
        .map { |r| r.tr("-", " ") }
    end

    def self.matches(token, column)
      Sequel.like(Sequel.function(:UPPER, column), "%#{token.upcase}%")
    end
  end
end
