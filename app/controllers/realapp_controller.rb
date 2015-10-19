class RealappController < ApplicationController

	require 'rubygems'
	require 'open-uri'
	require 'nokogiri'
	require 'httparty'

	require 'mechanize'
=begin
	def scrape
		@name = params[:user][:name]

		# search app and get the HTML from appannie
		# web_data = open('https://www.appannie.com/apps/ios/app/fitbit/', 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36")
		# doc = Nokogiri.HTML(web_data)

		if @name.start_with?("http://")
			# we won't use this, coz what we scrape mostly display after login, and the xpath is different before login
			doc = Nokogiri.HTML(open("#{@name}", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.89 Safari/537.36"))
		else
			f = File.open("/home/shirley/AppAnnie/public/#{@name}.xml")
			doc = Nokogiri::XML(f)
			f.close
		end

		# app name & link & icon
		@link = doc.xpath("//li[@class='current ']/a/@href").text
		@name = doc.xpath("//span[@class='name']").text
		@icon = doc.xpath("//img[@class='itc']/@src").text

		# app store
		@store = doc.xpath("//span[@itemprop='seller']/span[@itemprop='name']/@content").text
		# app price
		@price = doc.xpath("//span[@itemprop='price']/@content").text

		# app description
		@description = doc.xpath("//div[@itemprop='description']").text.gsub(/\n/, " ")

		# Average Ratings's country
		@country = doc.xpath("//span[@class='country']").text

		# get the 10 rating distribution numbers, current5 means the amount of five star rating
		@current5 = doc.xpath("//div[@id='r_current_content']//tr[1]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@current4 = doc.xpath("//div[@id='r_current_content']//tr[2]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@current3 = doc.xpath("//div[@id='r_current_content']//tr[3]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@current2 = doc.xpath("//div[@id='r_current_content']//tr[4]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@current1 = doc.xpath("//div[@id='r_current_content']//tr[5]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@all5 = doc.xpath("//div[@id='r_all_content']//tr[1]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@all4 = doc.xpath("//div[@id='r_all_content']//tr[2]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@all3 = doc.xpath("//div[@id='r_all_content']//tr[3]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@all2 = doc.xpath("//div[@id='r_all_content']//tr[4]//td[@class='count']").text.delete("(").delete(")").delete(",")
		@all1 = doc.xpath("//div[@id='r_all_content']//tr[5]//td[@class='count']").text.delete("(").delete(")").delete(",")

		# average & total volume
		@average_current = doc.xpath("//div[@id='r_current_content']//strong[1]").text
		@total_current = doc.xpath("//div[@id='r_current_content']//strong[last()]").text.delete(",")

		@average_all = doc.xpath("//div[@id='r_all_content']//strong[1]").text
		@total_all = doc.xpath("//div[@id='r_all_content']//strong[last()]").text.delete(",")

		# app compatibility
		@compatibility = doc.xpath("//b[.='Compatibility:']/following-sibling::text()[1]").text
		# app category
		@category = doc.xpath("//b[.='Category:']/following-sibling::text()[1]").text
		# app updated_date
		@updated_date = doc.xpath("//b[.='Updated:']/following-sibling::text()[1]").text
		# app size
		@size = doc.xpath("//b[.='Size:']/following-sibling::text()[1]").text
		# app seller
		@seller = doc.xpath("//b[.='Seller:']/following-sibling::text()[1]").text
		# app rating rated
		@rated = doc.xpath("//b[.='Rating: ']/following-sibling::text()[1]").text
		# app requirements
		@requirements = doc.xpath("//b[.='Requirements:']/following-sibling::text()[1]").text
		# app bundle id
		@bundleid = doc.xpath("//b[.='Bundle ID:']/following-sibling::text()[1]").text

		# screenshot, scrape only top five screenshots here
		@screenshot1 = doc.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[1]/a/@href").text
		@screenshot2 = doc.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[2]/a/@href").text
		@screenshot3 = doc.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[3]/a/@href").text
		@screenshot4 = doc.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[4]/a/@href").text
		@screenshot5 = doc.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[5]/a/@href").text

		Realapp.create(:link => "https://www.appannie.com#{@link}", :name => @name, :icon => @icon, :store => @store, :price => @price,
									:description => @description, :country => @country,
									:average_current => @average_current, :total_current => @total_current,
									:average_all => @average_all, :total_all => @total_all, 
									:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
									:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
									:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
									:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
									:screenshot1 => @screenshot1, :screenshot2 => @screenshot2, :screenshot3 => @screenshot3, 
									:screenshot4 => @screenshot4, :screenshot5 => @screenshot5)

	end

	def show
	end
=end
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

		@free = Ranking.all
		@free.each do |record|
			doc = agent.get("#{record.link}")

			# save a file and named it as the app name, it stores in the Appannie dir
			aFile = File.new("app.xml", "w+")
			aFile.syswrite(doc.body)

			f = File.open(aFile)
			currentfile = Nokogiri::XML(f)
			f.close

			# app name & link & icon
			@link = currentfile.xpath("//ul[@class='menu']/li[@class='current']/a/@href").text
			@name = currentfile.xpath("//div[@class='entity-name']").text
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

			# app compatibility
			@compatibility = currentfile.xpath("//b[.='Compatibility:']/following-sibling::text()[1]").text
			# app category
			@category = currentfile.xpath("//b[.='Category:']/following-sibling::text()[1]").text
			# app updated_date
			@updated_date = currentfile.xpath("//b[.='Updated:']/following-sibling::text()[1]").text
			# app size
			@size = currentfile.xpath("//b[.='Size:']/following-sibling::text()[1]").text
			# app seller
			@seller = currentfile.xpath("//b[.='Seller:']/following-sibling::text()[1]").text
			# app rating rated
			@rated = currentfile.xpath("//b[.='Rating: ']/following-sibling::text()[1]").text
			# app requirements
			@requirements = currentfile.xpath("//b[.='Requirements:']/following-sibling::text()[1]").text
			# app bundle id
			@bundleid = currentfile.xpath("//b[.='Bundle ID:']/following-sibling::text()[1]").text

			# screenshot, scrape only top five screenshots here
			@screenshot1 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[1]/a/@href").text
			@screenshot2 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[2]/a/@href").text
			@screenshot3 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[3]/a/@href").text
			@screenshot4 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[4]/a/@href").text
			@screenshot5 = currentfile.xpath("(//div[@id='screenshots']//div[@class='img-holder'])[5]/a/@href").text

			Realapp.create(:link => "https://www.appannie.com#{@link}", :name => @name, :icon => @icon, :store => @store, :price => @price,
									:description => @description, :country => @country,
									:average_current => @average_current, :total_current => @total_current,
									:average_all => @average_all, :total_all => @total_all, 
									:current1 => @current1, :current2 => @current2, :current3 => @current3, :current4 => @current4, :current5 => @current5,
									:all1 => @all1, :all2 => @all2, :all3 => @all3, :all4 => @all4, :all5 => @all5,
									:compatibility => @compatibility, :category => @category, :updated_date => @updated_date, 
									:size => @size, :seller => @seller, :rated => @rated, :requirements => @requirements, :bundleid => @bundleid,
									:screenshot1 => @screenshot1, :screenshot2 => @screenshot2, :screenshot3 => @screenshot3, 
									:screenshot4 => @screenshot4, :screenshot5 => @screenshot5)


			# delete what we save (the app file for scraping), it stores in the Appannie dir
			aFile.chmod(0777)
			File.delete(aFile)

			# avoid IP blocked by app annie because of frequently request 
      sleep (1 + Random.rand(3))
		end


	end


end
