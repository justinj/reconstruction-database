module RCDB
  describe BrestStats do
    let(:input) do
      <<EOF
[B]Step	Time	STM	stps	ETM	etps[/B]
[COLOR="red"]Total	5.88	53	9.01	57	9.69	[/COLOR]	[B][SIZE="4"]%[/SIZE]
							Step		Time	STM	ETM[/B]
Cross+1	1.62	13	8.02	14	8.64		Cross+1/F2L	40.2%	39.4%	38.9%
F2L	4.03	33	8.19	36	8.93		F2L/Total	68.5%	62.3%	63.2%
LL	1.85	20	10.81	21	11.35		LL/Total	31.5%	37.7%	36.8%
EOF
    end

    let(:stats) { BrestStats.parse(input) }

    it "finds the times" do
      stats["Total"]["Time"].must_equal 5.88
      stats["Cross+1"]["Time"].must_equal 1.62
    end
  end
end
