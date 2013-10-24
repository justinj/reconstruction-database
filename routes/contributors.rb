get "/contributors" do
  reconstructors = RCDB::Solve
    .group_and_count(:reconstructor_id)
    .reject { |entry| entry[:reconstructor_id].blank? }
    .map { |entry| {
      count: entry[:count],
      reconstructor: RCDB::Reconstructor.first(id: entry[:reconstructor_id]).name } }

  erb :contributors, locals: { entries: reconstructors }
end
