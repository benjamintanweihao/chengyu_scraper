# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'json'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

class ChengyuScraper
	def initialize
	end

	def chengyu_url(chengyu)
	  URI.escape("http://en.wiktionary.org/wiki/#{chengyu}".strip)
	end

	def run!
		chengyus = []

		file = File.open("./chengyu.json","w")

		File.open('./chengyu.txt').each_line do |chengyu|
			chengyus << parse!(chengyu)
		end

		file.write(chengyus.to_json)
		file.close
	end

	def parse!(chengyu)
		doc                 = Nokogiri::HTML(open(chengyu_url(chengyu)))
		pinyin              = doc.at('i:contains("Pinyin")').next_element.text.strip
		english_explanation = doc.at('ol').children.first.text.strip
		puts chengyu
		{
									:chengyu => chengyu.strip,
									:pinyin => pinyin,
			:english_explanation => english_explanation
		}
	end
end

puts ChengyuScraper.new.run!
