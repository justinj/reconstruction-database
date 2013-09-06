module RCDB
  describe Solve do

    after do
      destroy_db
    end

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
          solve.destroy
        end
      end
    end

    describe "tagging" do
      let(:solve) { Solve.create }

      it "lets you add tags" do
        Tag.expects(:find_or_create).with(name: "pllskip").returns(Tag.new)
        solve.tag("pllskip")
      end

      describe "tags=" do
        it "lets you set a bunch of tags at once" do
          Tag.expects(:create).times(3).returns(Tag.new)
          tags = ["a", "b", "c"].join("\n")
          solve.tags = tags
        end

        it "gets rid of old tags" do
          tags = ["a", "b", "c"].join("\n")
          solve.expects(:remove_all_tags)
          solve.tags = tags
        end
      end

      it "inherits tags from its average" do
        solve.stubs(:average).returns(stub(tags: ["average_tag"]))
        solve.all_tags.must_equal ["average_tag"]
      end
    end

    describe "solutions" do
      let(:solve) { Solve.create }
      describe "setting the solution" do

        it "creates a step" do
          Step.expects(:new).with(moves: %(R U R' U'),
                                  explanation: "Sexy move",
                                  position_in_solve: 0)
          solve.stubs(:add_step)
          solve.solution = "R U R' U' // Sexy move"
        end

        it "creates a step for each line" do
          Step.expects(:new).with(moves: %(U R U' R'),
                                  explanation: "Inverse sexy move",
                                  position_in_solve: 1)
          Step.expects(:new).with(moves: %(R U R' U'),
                                  explanation: "Sexy move",
                                  position_in_solve: 0)
          solve.stubs(:add_step)
          solve.solution = 
"R U R' U' // Sexy move
U R U' R' // Inverse sexy move"
        end
      end

      describe "getting the solution" do
        it "returns the formatted solution" do
          solve = Solve.new
          solve.stubs(:puzzle).returns(stub(delimiter: "//"))
          solve.stubs(:steps).returns([ stub(moves: "R", explanation: "move1", position_in_solve: 0),
                                        stub(moves: "U", explanation: "move2", position_in_solve: 1)])

          solve.solution.must_equal "R // move1\nU // move2"
        end

        it "uses the special delimiter if one is provided" do
          solve = Solve.new
          solve.stubs(:puzzle).returns(stub(delimiter: "-"))
          solve.stubs(:steps).returns([ stub(moves: "R", explanation: "move1", position_in_solve: 0),
                                        stub(moves: "U", explanation: "move2", position_in_solve: 1)])

          solve.solution.must_equal "R - move1\nU - move2"
        end
      end
    end

    describe "visibility" do
      it "is visible if it has a solution" do
        Solve.create(solution: "R U R' U'").must_be :visible?
        Solve.create(solution: "").wont_be :visible?
      end
    end
  end
end
