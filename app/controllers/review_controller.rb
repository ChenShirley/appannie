class ReviewController < ApplicationController

	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'

	def index
		# scrape 41 review once for an app
		# 496 records = 41*12 + 4 rating src (ignore the last 4 record of rating)

		# using inspector to get Messenger's latest 200 reviews (HTML)
		# since reviews showed after login, using file instead
		f = File.open("/home/shirley/AppAnnie/public/review.xml")
		doc = Nokogiri::XML(f)
		f.close

		# ratings, count star-whole.png......
		# equal to @rating = doc.xpath("//div[@class='ngCellText cell-inner ng-scope']/span[@aa-stars='']/nobr//img/@src")
		# one review with 6 img (5 star and 1 flag)
		@rating = doc.xpath("//img/@src")

		# review title
		@title = doc.xpath("//div[@class='ngCellText cell-inner cell-review ng-scope']/div/strong[@class='ng-binding']")

		# review author
		@author = doc.xpath("//div[@class='ngCellText cell-inner cell-review ng-scope']/div/span/strong[@class='ng-binding']")

		# review content
		@content = doc.xpath("//div[@class='review-content ng-binding']")

		# review date
		@date = doc.xpath("//div[@class='ngCellText cell-inner colt2 col-date']/span[@class='ng-binding']")

		# review country
		@country = doc.xpath("//div[@class='ngCellText cell-inner cell-country ng-scope']/span[@class='ng-binding']/@title")

		# review version
		@version = doc.xpath("//div[@class='ngCellText cell-inner colt4 col-version']/span[@class='ng-binding']")

		@rating.each do |record|
			Review.create(:whole => record.text)
		end
		@title.each do |record|
			Review.create(:whole => record.text)
		end
		@author.each do |record|
			Review.create(:whole => record.text)
		end
		@content.each do |record|
			Review.create(:whole => record.text)
		end
		@date.each do |record|
			Review.create(:whole => record.text)
		end
		@country.each do |record|
			Review.create(:whole => record.text)
		end
		@version.each do |record|
			Review.create(:whole => record.text)
		end

		# for view
		@feedback = Review.all
	end

end
