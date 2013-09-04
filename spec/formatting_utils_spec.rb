module RCDB
  describe FormattingUtils do
    include FormattingUtils

    it "formats times" do
      format_time("10.00").must_equal "10.00"
      format_time("10.0").must_equal "10.00"
      format_time("10").must_equal "10.00"
      format_time("60").must_equal "1:00.00"
      format_time("61").must_equal "1:01.00"
    end
  end
end
