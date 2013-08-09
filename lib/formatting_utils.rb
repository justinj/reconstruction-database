module ReconDatabase
  module FormattingUtils
    def format_time(time)
      if minutes(time) == "0"
        "#{seconds(time)}.#{pad_right hundredths(time)}"
      else
        "#{minutes(time)}:#{pad_left seconds(time)}.#{hundredths(time)}"
      end
    end

    private

    def minutes(time)
      (time.to_s.split(".").first.to_i / 60).to_s
    end

    def seconds(time)
      (time.to_s.split(".").first.to_i % 60).to_s
    end

    def hundredths(time)
      time.to_s.split(".").last
    end

    def pad_left(num, num_digits = 2)
      num = num.to_s
      num = "0" + num until num.length >= num_digits
      num[0...num_digits]
    end

    def pad_right(num, num_digits = 2)
      num = num.to_s
      num = num + "0" until num.length >= num_digits
      num[0...num_digits]
    end
  end
end
