get "/contributors" do
  erb :contributors, locals: { data: RCDB::Solve.group_and_count(:reconstructor) }
end
