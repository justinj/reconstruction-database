module RCDB
  describe PuzzleRenamer do
    it "renames events to the names RCDB uses" do
      PuzzleRenamer.rename("3bld").must_equal "3x3BLD"
      PuzzleRenamer.rename("3x3x3").must_equal "3x3"
    end
  end
end
