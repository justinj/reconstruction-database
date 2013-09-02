module RCDB
  describe Solve do

    let(:regular_solve) { Solve.new(time: 10.00) }
    let(:plus_two_solve) { Solve.new(time: 10.00, penalty: "+2") }
    let(:dnf_solve) { Solve.new(time: 10.00, penalty: "dnf") }

    describe "effective value" do
      it "is the time of the solve" do
        regular_solve.effective_value.must_equal 10.00
      end

      it "is the time plus two with a plus two penalty" do
        plus_two_solve.effective_value.must_equal 12.00
      end

      it "is the time for a dnf" do
        dnf_solve.effective_value.must_equal 10.00
      end
    end

    describe "formatting" do
      it "is just the time for no penalty" do
        regular_solve.format.must_equal "10.00"
      end

      it "is the penalty time with a + for a +2" do
        plus_two_solve.format.must_equal "12.00+"
      end

      it "is DNF(<time>) for a dnf" do
        dnf_solve.format.must_equal "DNF(10.00)"
      end
    end

    describe "penalties" do
      it "knows when it is a dnf" do
        dnf_solve.dnf?.must_equal true
        regular_solve.dnf?.must_equal false
      end

      it "knows when it is a +2" do
        plus_two_solve.plus_two?.must_equal true
        regular_solve.plus_two?.must_equal false
      end
    end

    describe "saving" do
      it "saves the added date" do
        Timecop.freeze do
          solve = Solve.new
          solve.save
          solve.date_added.must_be_close_to Time.now
        end
      end
    end

    describe "tagging" do
      let(:solve) { Solve.create }
      before do
        Tag.each { |t| t.destroy }
      end

      it "lets you add tags" do
        solve.tags.count.must_equal 0
        solve.tag("pllskip")
        solve.tags.count.must_equal 1
      end

      it "doesn't tag more than once" do
        solve.tags.count.must_equal 0
        solve.tag("pllskip")
        solve.tag("pllskip")
        solve.tags.count.must_equal 1
      end

      describe "tags=" do
        it "lets you set a bunch of tags at once" do
          tags = ["a", "b", "c"].join("\n")
          solve.tags.count.must_equal 0
          solve.tags = tags
          solve.tags.count.must_equal 3
        end

        it "gets rid of old tags" do
          solve.tag "d"
          tags = ["a", "b", "c"].join("\n")
          solve.tags.count.must_equal 1
          solve.tags = tags
          solve.tags.count.must_equal 3
        end
      end

      it "creates a new tag if one doesn't exist" do
        solve.tag("pllskip")
        Tag.count.must_equal 1
      end

      it "doesn't create a new tag if one exists" do
        Tag.create(name: "pllskip")
        solve.tag("pllskip")
        Tag.count.must_equal 1
      end

      it "inherits tags from its average" do
        solve.stubs(:average).returns(stub(tags: ["average_tag"]))
        solve.all_tags.must_equal ["average_tag"]
      end
    end
  end
end
