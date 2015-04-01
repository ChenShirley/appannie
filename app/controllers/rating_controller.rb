class RatingController < ApplicationController
	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'

	def index

# free app ratings
		@free = Fullrank.where("apptype=?",'free')
		
		@free.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# app compatibility
			@compatibility = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Compatibility:']/following-sibling::text()[1]").text
			# app category
			@category = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Category:']/following-sibling::text()[1]").text
			# app updated_date
			@updated_date = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Updated:']/following-sibling::text()[1]").text
			# app size
			@size = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Size:']/following-sibling::text()[1]").text
			# app seller
			@seller = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Seller:']/following-sibling::text()[1]").text
			# app rating rated
			@rated = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Rating: ']/following-sibling::text()[1]").text
			# app requirements
			@requirements = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Requirements:']/following-sibling::text()[1]").text
			# app bundle id
			@bundleid = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Bundle ID:']/following-sibling::text()[1]").text

			# get the Average Ratings's country
			@country = doc.xpath("//h3[@class='rating_head']//span[@class='country']").text

			# get the 10 rating distribution numbers, current1 means the amount of five star rating
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
			@total_all = doc.xpath("//div[@id='r_all_content']//strong[last()]").text

			Fullrating.create(:name => @appname, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

			# avoid IP blocked by app annie because of frequently request 
      sleep 5
		end

# paid app ratings
		@paid = Fullrank.where("apptype=?",'paid')
		
		@paid.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# app compatibility
			@compatibility = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Compatibility:']/following-sibling::text()[1]").text
			# app category
			@category = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Category:']/following-sibling::text()[1]").text
			# app updated_date
			@updated_date = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Updated:']/following-sibling::text()[1]").text
			# app size
			@size = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Size:']/following-sibling::text()[1]").text
			# app seller
			@seller = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Seller:']/following-sibling::text()[1]").text
			# app rating rated
			@rated = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Rating: ']/following-sibling::text()[1]").text
			# app requirements
			@requirements = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Requirements:']/following-sibling::text()[1]").text
			# app bundle id
			@bundleid = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Bundle ID:']/following-sibling::text()[1]").text

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
			@total_all = doc.xpath("//div[@id='r_all_content']//strong[last()]").text

			Fullrating.create(:name => @appname, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

      sleep 5
		end

# grossing app ratings
		@grossing = Fullrank.where("apptype=?",'grossing')
		
		@grossing.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text

			# app compatibility
			@compatibility = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Compatibility:']/following-sibling::text()[1]").text
			# app category
			@category = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Category:']/following-sibling::text()[1]").text
			# app updated_date
			@updated_date = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Updated:']/following-sibling::text()[1]").text
			# app size
			@size = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Size:']/following-sibling::text()[1]").text
			# app seller
			@seller = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Seller:']/following-sibling::text()[1]").text
			# app rating rated
			@rated = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Rating: ']/following-sibling::text()[1]").text
			# app requirements
			@requirements = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Requirements:']/following-sibling::text()[1]").text
			# app bundle id
			@bundleid = doc.xpath("//div[@class='app-box-itemlist about_app']//div[@class='app-box-content']//p//b[.='Bundle ID:']/following-sibling::text()[1]").text

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
			@total_all = doc.xpath("//div[@id='r_all_content']//strong[last()]").text

			Fullrating.create(:name => @appname, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

      sleep 5
		end

		# show rating information from database to check whether it is success or not
		@rating = Fullrating.limit(2).all

	end
end