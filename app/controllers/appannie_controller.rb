class AppannieController < ApplicationController
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	def index
		web_data = open('http://www.appannie.com/apps/ios/app/facebook/')
		doc = Nokogiri.HTML(web_data)
		# url = "http://www.appannie.com/apps/ios/app/facebook/"
		# doc = Nokogiri.HTML(open(url))
		@achievements = doc.xpath("//td[@class='count']")
	end

end
