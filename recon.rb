require "nokogiri"
require "sequel"

def download_page(n)
  puts "downloading #{n}"
  `curl http://www.speedsolving.com/forum/showthread.php?29123-The-reconstruction-thread/page#{n} > pages/page_#{n}.html`
end

def parse_page(n)
  doc = Nokogiri::HTML(open("pages/page_#{n}.html"))
  posts = doc.search(".postcontent")

  File.open("posts/posts_#{n}.txt", "w") { |f| f.write posts.map(&:content).join("\n%%\n").gsub("\r", "") }
end

1.upto(81) { |n| parse_page(n) }
