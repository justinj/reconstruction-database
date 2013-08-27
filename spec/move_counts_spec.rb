require_relative "spec_helper"

module RCDB
  module MoveCounts
    def htm(alg)
      no_comments = remove_comments(alg)
      no_comments.scan(/(#{moves.join("|")})/).count 
    end

    def stm(alg)
      htm(alg.gsub(/(.)2/, '\1 \1'))
    end

    private

    def remove_comments(text)
      text.gsub(/\/\/.*?$/, "")
    end

    def moves
      %w(L R U D F B)
    end

  end


  describe MoveCounts do
    include MoveCounts
    describe "HTM" do
      it "considers each turn of a single face a move" do
        htm("R U R' U'").must_equal 4
      end

      it "counts double turns and single turns the same" do
        htm("R").must_equal 1
        htm("R2").must_equal 1
        htm("R'").must_equal 1
      end

      it "ignores whitespace" do
        htm("RUR'U'").must_equal 4
      end

      it "handles wide moves" do
        htm("RwUwRU'").must_equal 4
        htm("Rw Uw R U'").must_equal 4
      end

      it "ignores comments" do
        htm("R U R' U' // R U2 R' 
             R U2 R' U' // Another Comment R U R").must_equal 8
      end
    end

    describe "STM" do
      it "considers each quarter turn a turn" do
        stm("R U R' U'").must_equal 4
      end

      it "counts double turns as 2" do
        stm("R").must_equal 1
        stm("R2").must_equal 2
        stm("R'").must_equal 1
      end
    end

  end
end
