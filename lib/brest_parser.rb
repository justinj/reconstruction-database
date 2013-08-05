class BrestParser
  attr_reader :post, :name, :solves

  def initialize(filepath)
    @filepath = filepath
    parse
  end

  def save_to(db)
    solves.each do |solve|
      db.add({
        scramble: solve[:scramble],
        solution: solve[:solution],
        solver: solve[:solver],
        time: solve[:time],
        youtube: solve[:youtube],
        competition: solve[:competition],
        puzzle: solve[:puzzle]
      })
    end
  end

  private

  def parse
    @post = File.read(@filepath)
    @solves = (0...number_of_solves).map { |i| parse_single_solve(@post, i) }
  end

  def number_of_solves
    count = @post.scan(/SPOILER=[^\]]*?\ssolve/).count
    count = 1 if count == 0
    count
  end

  def parse_single_solve(post, which)
    solve = {}

    solve[:youtube]     = parse_youtube(post)
    solve[:puzzle]      = parse_puzzle(post)
    solve[:competition] = parse_competition(post)
    solve[:solver]      = parse_solver(post)

    solve[:time]        = parse_time(post, which)
    solve[:scramble]    = parse_scramble(post, which)
    solve[:solution]    = parse_solution(post,which)

    solve
  end

  def parse_solver(post)
    summary_line(post)[0]
  end
  
  def parse_time(post, which)
    times = post.scan /Total\s+(\d+\.\d+)[^%]/
    if times && times[which]
      times[which][0].to_f
    end
  end

  def parse_competition(post)
    summary_line(post).fetch(2, "Unofficial").strip
  end

  def parse_puzzle(tree)
    description = summary_line(tree)[1]
    if description.split(" ").count > 2
      fix_puzzle_name(extract_puzzle description)
    else
      default_puzzle
    end
  end

  def fix_puzzle_name(puzzle_name)
    return default_puzzle if puzzle_name.nil?
    if /^\dx\dx\d$/ =~ puzzle_name
      puzzle_name[0..2]
    else
      puzzle_name
    end
  end

  def extract_puzzle(description)
    description.split(" ")[1]
  end

  def default_puzzle
    "3x3"
  end

  def summary_line(post)
    post.gsub(/\[.*?\]/, "").lines.first.split(/\s+-\s+/)
  end

  def parse_youtube(post)
    /\[youtubehd\](?<result>.*?)\[\/youtubehd\]/ =~ post 
   
    result
  end

  def parse_scramble(post, which)
    scramble_from_garron_link(nth_garron_link(post, which))
  end

  def parse_solution(post, which)
    solution_from_garron_link(nth_garron_link(post, which))
  end

  def nth_garron_link(post, n)
    garron_links = post.scan(/\[url=(.*?)\]/)
    n = n * 2 if garron_links.count > number_of_solves # sometimes, every garron link appears twice
    garron_links[n]
  end

  def solution_from_garron_link(link)
    parse_garron_link(link, "alg")
  end

  def scramble_from_garron_link(link)
    parse_garron_link(link, "ini")
  end

  def parse_garron_link(link, prop)
    return "" if link.nil?
    parameter = link.first.split(/(&|\?)/).grep(/#{prop}=/).first
    parameter["#{prop}="] = ""
    parameter.gsub!("%0A", "\n")
    parameter.gsub!('"', "")
    parameter.tr("-_","' ")
  end

  def youtube_and_scramble_line(tree)
    tree.content.lines[2].split(/\s+/, 2)
  end
end
