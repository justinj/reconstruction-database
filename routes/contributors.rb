get "/contributors" do
  reconstructors = RCDB::Solve
    .group_and_count(:reconstructor_id)
    .map { |entry| {
      count: entry[:count],
      reconstructor: RCDB::Reconstructor.first(id: entry[:reconstructor_id]).name } }
    .reject { |entry| entry[:reconstructor].blank? }

  erb :contributors, locals: { entries: reconstructors }
end
