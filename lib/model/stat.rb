module RCDB
  class Stat < Sequel::Model
    many_to_one :stat_section

    def tps
      return "" unless amount && stat_section.time
      return "" if stat_section.time.zero?
      round(amount / stat_section.time)
    end

    def round(number)
      (number * 100.0).round / 100.0
    end
  end
end
