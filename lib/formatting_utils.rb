module RCDB
  module FormattingUtils
    def format_time(time)
      if minutes(time) == "0"
        "#{seconds(time)}.#{pad_right hundredths(time)}"
      else
        "#{minutes(time)}:#{pad_left seconds(time)}.#{hundredths(time)}"
      end
    end

    private

    def canonical_time(time)
      time.to_f.to_s
    end

    def minutes(time)
      (canonical_time(time).split(".").first.to_i / 60).to_s
    end

    def seconds(time)
      (canonical_time(time).split(".").first.to_i % 60).to_s
    end

    def hundredths(time)
      pad_right(canonical_time(time).split(".").last)
    end

    def pad_left(num, num_digits = 2)
      str_num = num.to_s
      str_num = "0" + str_num until str_num.length >= num_digits
      str_num[0...num_digits]
    end

    def pad_right(num, num_digits = 2)
      str_num = num.to_s
      str_num = str_num + "0" until str_num.length >= num_digits
      str_num[0...num_digits]
    end
  end
end
