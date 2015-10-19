class RatingController < ApplicationController
	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'

	require 'mechanize'

	def index
		agent = Mechanize.new

		# Below opens URL requesting username and finds first field and fills in form then submits page.
		login = agent.get('https://www.appannie.com/account/login')
		login_form = login.form
		username_field = login_form.field_with(:name => "username")
		username_field.value = ENV["USERNAME"]
		password_field = login_form.field_with(:name => "password")
		password_field.value = ENV["PASSWORD"]
		home_page = login_form.submit

		# Below will print page showing information confirming that you have logged in.
		# pp login

		@free = Fullrank.where("apptype=?",'free')

		# @free = Fullrank.where("apptype=? AND (id>? AND id<?)",'paid',442,495)
		@free.each do |record|
			# used when ip blocked by appannie
			# @ U = Fullrating.find_by_fullrank_id(record.id)

			doc = agent.get("#{record.link}")
			# doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# save a file and named it as the app name, it stores in the Appannie dir

			aFile = File.new("app.xml", "w+")
			aFile.syswrite(doc.body)

			f = File.open(aFile)
			currentfile = Nokogiri::XML(f)
			f.close

			# app name & link & icon
			@link = currentfile.xpath("//li[@class='current ']/a/@href").text
			@name = currentfile.xpath("//span[@class='name']").text
			@icon = currentfile.xpath("//img[@class='itc']/@src").text

			# app store
			#@store = currentfile.xpath("//span[@itemprop='seller']/span[@itemprop='name']/@content").text
			@store = currentfile.xpath("//a[@title='iOS Store']").text
			# app price
			@price = currentfile.xpath("//span[@itemprop='price']/@content").text

			# app description
			@description = currentfile.xpath("//div[@itemprop='description']").text.gsub(/\n/, " ")

			# Average Ratings's country
			@country = currentfile.xpath("//span[@class='country']").text

			# get the 10 rating distribution numbers, current5 means the amount of five star rating
			@current5 = currentfile.xpath("//div[@id='r_current_content']//tr[1]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@current4 = currentfile.xpath("//div[@id='r_current_content']//tr[2]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@current3 = currentfile.xpath("//div[@id='r_current_content']//tr[3]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@current2 = currentfile.xpath("//div[@id='r_current_content']//tr[4]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@current1 = currentfile.xpath("//div[@id='r_current_content']//tr[5]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@all5 = currentfile.xpath("//div[@id='r_all_content']//tr[1]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@all4 = currentfile.xpath("//div[@id='r_all_content']//tr[2]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@all3 = currentfile.xpath("//div[@id='r_all_content']//tr[3]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@all2 = currentfile.xpath("//div[@id='r_all_content']//tr[4]//td[@class='count']").text.delete("(").delete(")").delete(",")
			@all1 = currentfile.xpath("//div[@id='r_all_content']//tr[5]//td[@class='count']").text.delete("(").delete(")").delete(",")

			# average & total volume
			@average_current = currentfile.xpath("//div[@id='r_current_content']//strong[1]").text
			@total_current = currentfile.xpath("//div[@id='r_current_content']//strong[last()]").text.delete(",")

			@average_all = currentfile.xpath("//div[@id='r_all_content']//strong[1]").text
			@total_all = currentfile.xpath("//div[@id='r_all_content']//strong[last()]").text.delete(",")

			# screenshot, scrape only top five screenshots here
			@screenshot1 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[1]/a/@href").text
			@screenshot2 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[2]/a/@href").text
			@screenshot3 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[3]/a/@href").text
			@screenshot4 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[4]/a/@href").text
			@screenshot5 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[5]/a/@href").text

			Fullrating.create(:link => "https://www.appannie.com#{@link}", :name => @name, :icon => @icon, :store => @store, :price => @price,
										:description => @description, :country => @country,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:screenshot1 => @screenshot1, :screenshot2 => @screenshot2, :screenshot3 => @screenshot3, 
										:screenshot4 => @screenshot4, :screenshot5 => @screenshot5,
										:fullrank_id => record.id)

			# delete what we save (the app file for scraping), it stores in the Appannie dir
			aFile.chmod(0777)
			File.delete(aFile)

			# avoid IP blocked by app annie because of frequently request 
      sleep (1 + Random.rand(3))
		end

=begin
# free app ratings
		@free = Fullrank.where("apptype=?",'free')
		
		@free.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top aa-info-columns aa-info-columns-app']//h2[@class='asset-name']").text
			# app store
			@store = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='seller']/span[@itemprop='name']/@content").text
			# app price
			@price = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='price']/@content").text

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

			Fullrating.create(:name => @appname, :store => @store, :price => @price, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

			# avoid IP blocked by app annie because of frequently request 
      sleep 2
		end

# paid app ratings
		@paid = Fullrank.where("apptype=?",'paid')
		
		@paid.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text
			# app store
			@store = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='seller']/span[@itemprop='name']/@content").text
			# app price
			@price = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='price']/@content").text

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

			Fullrating.create(:name => @appname, :store => @store, :price => @price, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

      sleep 2
		end

# grossing app ratings
		@grossing = Fullrank.where("apptype=?",'grossing')
		
		@grossing.each do |record|
			doc = Nokogiri.HTML(open("#{record.link}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))

			# app name
			@appname = doc.xpath("//div[@class='app-info-top']//h2[@class='asset-name ']").text
			# app store
			@store = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='seller']/span[@itemprop='name']/@content").text
			# app price
			@price = doc.xpath("//div[@class='sidebar-inner']//span[@itemprop='price']/@content").text

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

			Fullrating.create(:name => @appname, :store => @store, :price => @price, :country => @country,
										:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
										:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
										:average_current => @average_current, :total_current => @total_current,
										:average_all => @average_all, :total_all => @total_all, 
										:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
										:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
										:fullrank_id => record.id)

      sleep 2
		end
=end
		# show rating information from database to check whether it is success or not
		@rating = Fullrating.limit(2).all

	end

end
