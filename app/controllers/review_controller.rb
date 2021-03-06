class ReviewController < ApplicationController

	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'


	def scrape
		@name = params[:user][:name]
		f = File.open("/home/shirley/AppAnnie/public/#{@name}.xml")
		doc = Nokogiri::XML(f)
		f.close
		# can only scrape 41 reviews once for an app
		# 496 records = 41*12 + 4 rating src (plz ignore the last 4 record of rating)

		# using inspector to get Messenger's latest 50 reviews (HTML)
		# since reviews showed after login, using file instead

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

		# only scrape 40 reviews here, to calculate which attritube are in the same review
		i=1
		whole="/media/pictures/star-whole.png"
		blank="/media/pictures/star-blank.png"
		while ( i <= 40 )
			if @rating[6*i-2].text.eql?(whole)
				star=5
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(whole)
				star=4
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(blank) && @rating[6*i-4].text.eql?(whole)
				star=3
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(blank) && @rating[6*i-4].text.eql?(blank) && @rating[6*i-5].text.eql?(whole)
				star=2
			else
				star=1
			end

			Review.create(:name => @name, :star => star, 
										:title => @title[i-1].text, :author => @author[i-1].text, :content => @content[i-1].text, 
										:date => @date[i-1].text, :country => @country[i-1].text, :version => @version[i-1].text)
			i = i + 1
		end
	end

	def show
	end


	def index
=begin
		# can only scrape 41 reviews once for an app
		# 496 records = 41*12 + 4 rating src (plz ignore the last 4 record of rating)

		# using inspector to get Messenger's latest 50 reviews (HTML)
		# since reviews showed after login, using file instead
		f = File.open("/home/shirley/AppAnnie/public/fitbit_review.xml")
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

		# only scrape 40 reviews here, to calculate which attritube are in the same review
		i=1
		whole="/media/pictures/star-whole.png"
		blank="/media/pictures/star-blank.png"
		while ( i <= 40 )
			if @rating[6*i-2].text.eql?(whole)
				star=5
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(whole)
				star=4
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(blank) && @rating[6*i-4].text.eql?(whole)
				star=3
			elsif @rating[6*i-2].text.eql?(blank) && @rating[6*i-3].text.eql?(blank) && @rating[6*i-4].text.eql?(blank) && @rating[6*i-5].text.eql?(whole)
				star=2
			else
				star=1
			end

			Review.create(:name => "fitbit", :star => star, 
										:title => @title[i-1].text, :author => @author[i-1].text, :content => @content[i-1].text, 
										:date => @date[i-1].text, :country => @country[i-1].text, :version => @version[i-1].text)
			i = i + 1
		end
=end
		# for view
		@feedback = Review.all
	end

end
