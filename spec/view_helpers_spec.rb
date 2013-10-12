module RCDB
  describe ViewHelpers do
    include RCDB::ViewHelpers
    it "formats the date of a solve" do
      date = Date.new(2010,8,10)
      date_added(stub(date_added: date)).must_equal "Aug 10, 2010"
    end

    describe "pagination" do
      let(:dataset) { mock }
      let(:params) { {} }
      it "defaults to the first page and 100 entries" do
        dataset.expects(:paginate).with(1, 100)
        paginate(dataset)
      end

      it "reads the `params`" do
        params["page"] = "2"
        dataset.expects(:paginate).with(2, 100)
        paginate(dataset)
      end
    end

    describe "garron links" do
      before do
        stubs(:erb).returns("result")
      end

      it "creates garron links for a solve" do
        solve = stub(solution: "R U R' U'",
                     scramble: "U R U' R'",
                     puzzle: stub(garronized_name: "3x3"))
        expected = "http://alg.garron.us/?alg=R_U_R-_U-&ini=U_R_U-_R-&cube=3x3&name=result"
        garronize(solve).must_equal expected
      end

      it "adds &displines=0 to solutions longer than 12 lines" do
        solution = (["R"] * 13).join("\n")
        solve = stub(solution: solution,
                     scramble: "U",
                     puzzle: stub(garronized_name: "3x3"))
        expected =  "http://alg.garron.us/?alg=R%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR%0AR&ini=U&cube=3x3&name=result&displines=0"
        garronize(solve).must_equal expected
      end

      it "adds &animtype=solve if there is no scramble" do
        solve = stub(solution: "R",
                     scramble: "",
                     puzzle: stub(garronized_name: "3x3"))
        expected =  "http://alg.garron.us/?alg=R&animtype=solve&cube=3x3&name=result"
        garronize(solve).must_equal expected
      end

      it "creates garron links" do
        solve = stub(solution: "R' U",
                     scramble: "U' R")


        stubs(:render_solution).returns("R' U")

        solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
        garronize(solve)
        .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2&name=result"
      end

      it "removes links from names" do
        solve = stub(solution: "R' U",
                     scramble: "U' R")


        stubs(:erb).returns("result<tag>")
        stubs(:render_solution).returns("R' U")

        solve.stubs(:puzzle).returns(stub(garronized_name: "2x2x2"))
        garronize(solve)
        .must_equal "http://alg.garron.us/?alg=R-_U&ini=U-_R&cube=2x2x2&name=result"
      end

    end
  end
end
