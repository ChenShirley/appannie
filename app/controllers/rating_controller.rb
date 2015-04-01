class RatingController < ApplicationController
	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'

	def index

# free app ratings
		@free = Ranking.where("apptype=?",'free')
		
		@free.each do |record|

			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))
			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# get the Average Ratings's country
			@country = doc.xpath("//h3[@class='rating_head']//span[@class='country']").text

			# get the 10 rating distribution numbers
			@current1 = doc.xpath("//div[@id='r_current_content']//tr[1]//td[@class='count']").text
			@current2 = doc.xpath("//div[@id='r_current_content']//tr[2]//td[@class='count']").text
			@current3 = doc.xpath("//div[@id='r_current_content']//tr[3]//td[@class='count']").text
			@current4 = doc.xpath("//div[@id='r_current_content']//tr[4]//td[@class='count']").text
			@current5 = doc.xpath("//div[@id='r_current_content']//tr[5]//td[@class='count']").text
			@all1 = doc.xpath("//div[@id='r_all_content']//tr[1]//td[@class='count']").text
			@all2 = doc.xpath("//div[@id='r_all_content']//tr[2]//td[@class='count']").text
			@all3 = doc.xpath("//div[@id='r_all_content']//tr[3]//td[@class='count']").text
			@all4 = doc.xpath("//div[@id='r_all_content']//tr[4]//td[@class='count']").text
			@all5 = doc.xpath("//div[@id='r_all_content']//tr[5]//td[@class='count']").text

			# average & total volume
			@average_current = doc.xpath("//div[@id='r_current_content']//strong[1]").text
			@total_current = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			@average_all = doc.xpath("//div[@id='r_all_content']//strong[1]").text
			@total_all = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			Rating.create(:name => @appname, :country => @country,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:ranking_id => record.id)

      sleep 10

		end

      sleep 15
# paid app ratings
		@paid = Ranking.where("apptype=?",'paid')
		
		@paid.each do |record|

			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))
			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# get the Average Ratings's country
			@country = doc.xpath("//h3[@class='rating_head']//span[@class='country']").text

			# get the 10 rating distribution numbers
			@current1 = doc.xpath("//div[@id='r_current_content']//tr[1]//td[@class='count']").text
			@current2 = doc.xpath("//div[@id='r_current_content']//tr[2]//td[@class='count']").text
			@current3 = doc.xpath("//div[@id='r_current_content']//tr[3]//td[@class='count']").text
			@current4 = doc.xpath("//div[@id='r_current_content']//tr[4]//td[@class='count']").text
			@current5 = doc.xpath("//div[@id='r_current_content']//tr[5]//td[@class='count']").text
			@all1 = doc.xpath("//div[@id='r_all_content']//tr[1]//td[@class='count']").text
			@all2 = doc.xpath("//div[@id='r_all_content']//tr[2]//td[@class='count']").text
			@all3 = doc.xpath("//div[@id='r_all_content']//tr[3]//td[@class='count']").text
			@all4 = doc.xpath("//div[@id='r_all_content']//tr[4]//td[@class='count']").text
			@all5 = doc.xpath("//div[@id='r_all_content']//tr[5]//td[@class='count']").text

			# average & total volume
			@average_current = doc.xpath("//div[@id='r_current_content']//strong[1]").text
			@total_current = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			@average_all = doc.xpath("//div[@id='r_all_content']//strong[1]").text
			@total_all = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			Rating.create(:name => @appname, :country => @country,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:ranking_id => record.id)

      sleep 10

		end

      sleep 15
# grossing app ratings
		@grossing = Ranking.where("apptype=?",'grossing')
		
		@grossing.each do |record|

			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))
			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# get the Average Ratings's country
			@country = doc.xpath("//h3[@class='rating_head']//span[@class='country']").text

			# get the 10 rating distribution numbers
			@current1 = doc.xpath("//div[@id='r_current_content']//tr[1]//td[@class='count']").text
			@current2 = doc.xpath("//div[@id='r_current_content']//tr[2]//td[@class='count']").text
			@current3 = doc.xpath("//div[@id='r_current_content']//tr[3]//td[@class='count']").text
			@current4 = doc.xpath("//div[@id='r_current_content']//tr[4]//td[@class='count']").text
			@current5 = doc.xpath("//div[@id='r_current_content']//tr[5]//td[@class='count']").text
			@all1 = doc.xpath("//div[@id='r_all_content']//tr[1]//td[@class='count']").text
			@all2 = doc.xpath("//div[@id='r_all_content']//tr[2]//td[@class='count']").text
			@all3 = doc.xpath("//div[@id='r_all_content']//tr[3]//td[@class='count']").text
			@all4 = doc.xpath("//div[@id='r_all_content']//tr[4]//td[@class='count']").text
			@all5 = doc.xpath("//div[@id='r_all_content']//tr[5]//td[@class='count']").text

			# average & total volume
			@average_current = doc.xpath("//div[@id='r_current_content']//strong[1]").text
			@total_current = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			@average_all = doc.xpath("//div[@id='r_all_content']//strong[1]").text
			@total_all = doc.xpath("//div[@id='r_current_content']//strong[last()]").text

			Rating.create(:name => @appname, :country => @country,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:ranking_id => record.id)

      sleep 10

		end

		@rating = Rating.limit(3).all

	end
end
