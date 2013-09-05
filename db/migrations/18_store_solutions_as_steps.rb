# The Sequel website recommends copying code from your models, rather than referencing them
require "json"


def extract_steps(solution)
  (solution || "").lines.grep(%r(//)).each_with_index.map do |line, i|
    moves, explanation = line.chomp.split(%r$\s*//\s*$)
    {moves: moves,
      explanation: explanation,
      position_in_solve: i}
  end
end


Sequel.migration do
  change do
    create_table(:steps) do
      primary_key :id
      String :moves
      String :explanation
      Integer :solve_id
      Integer :position_in_solve
    end

    from(:solves).each do |solve|
      steps = extract_steps(solve[:solution])      
      steps.each do |step|
        step[:solve_id] = solve[:id]
        from(:steps).insert(step)
      end
    end
  end
end
