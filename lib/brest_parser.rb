class BrestParser
  attr_reader :post, :lines, :name, :time, :competition

  def initialize(filepath)
    @filepath = filepath
    parse
  end

  def number_of_solves
    1
  end

  def youtube
    youtube_and_scramble_line.split(/\s+/,2)[0].strip
  end

  def scramble
    youtube_and_scramble_line.split(/\s+/,2)[1].strip
  end

  def solution
    lines
     .drop_while { |line| !(line =~ /\/\//) }
     .take_while { |line| line =~ /\/\// }.join
  end

  def save_to(db)
    db.add({
      scramble: scramble,
      solution: solution,
      solver: name,
      time: time,
      youtube: youtube,
      competition: competition,
      puzzle: "3x3x3" # assume this until we have a better way
    })
  end

  private

  ALG_REGEX = /((U|D|L|R|F|B)('|2)? ?)+/

  def parse
    @post = File.read(@filepath)
    @post.gsub!(/\[.*?\]/, "")
    @lines = @post.lines
    parse_first_line
  end

  def parse_first_line
    name, description, competition = lines.first.split(/\s+-\s+/)
    @name = name
    @time = description[/\d+\.\d+/].to_f
    @competition = competition.strip
  end

  def youtube_and_scramble_line
    lines[2]
  end
end

