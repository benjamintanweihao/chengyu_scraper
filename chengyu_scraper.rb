# encoding: UTF-8
require "nokogiri"
require "open-uri"

class ChengyuScraper
	def initialize
	end

	def chengyu_url(chengyu)
	  URI.escape("http://en.wiktionary.org/wiki/#{chengyu}")
	end

	def run!
		File.open('./chengyu.txt').each_line do |chengyu|
			parse!(chengyu)
		end
	end

	def parse!(chengyu)
		doc                 = Nokogiri::HTML(open(chengyu_url(chengyu)))
		pinyin              = doc.at('i:contains("Pinyin")').next_element.text.strip
		english_explanation = doc.at('ol').children.first.text.strip
		[chengyu, pinyin, english_explanation]
	end
end

puts ChengyuScraper.new.run!
