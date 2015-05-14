require "nokogiri"
require "open-uri"
require "thread"
require "fileutils"

include FileUtils

Dir.chdir(File.expand_path("../case", __FILE__)) do
  docs = Queue.new

  total = 190

  (1..total).each do |i|
    Thread.new do
      file = "#{i}.html"
      docs << [i, file, Nokogiri::HTML(open(file))]
    end
  end

  total.times do
    num, file, doc = docs.pop
    title = "# #{num}: %s" % doc.css("h1.title").text
    body = doc.css("div#contenttext").text
    output_text = [title, body].join("\n\n")
    File.write("#{num}.md", output_text)
  end
end
