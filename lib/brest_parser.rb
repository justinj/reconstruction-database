require "nokogiri"

class BrestParser
  attr_reader :post, :name, :solves

  def initialize(filepath)
    @filepath = filepath
    parse
  end

  def puzzle
    @puzzle || "3x3"
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
    number_of_solves = @post.scan("View as executed").count
    @solves = (0...number_of_solves).map { |i| parse_single_solve(@post, i) }
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
    summary_line(post)[2].strip
  end

  def parse_puzzle(tree)
    description = summary_line(tree)[1]
    if description.split(" ").count > 2
      extract_puzzle description
    else
      "3x3"
    end
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
    n = n * 2 # each link appears twice
    post.scan(/\[url=(.*?)\]/)[n]
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

  def extract_puzzle(description)
    description.split(" ")[1]
  end

  def youtube_and_scramble_line(tree)
    tree.content.lines[2].split(/\s+/, 2)
  end
end

