class MockupController < ApplicationController
=begin
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
=end

	def random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		a = a1+Random.rand(a2-a1)
		b = b1+Random.rand(b2-b1)
		c = c1+Random.rand(c2-c1)
		d = d1+Random.rand(d2-d1)
		e = e1+Random.rand(e2-e1)
		@bar5 = (num*((a.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar4 = (num*((b.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar3 = (num*((c.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar2 = (num*((d.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		@bar1 = (num*((e.fdiv(a+b+c+d+e)*100).round(1)).fdiv(100)).round
		if (@bar5+@bar4+@bar3+@bar2+@bar1)!=num
				@bar2 = (num-(@bar5+@bar4+@bar3+@bar1)).round
		end
		if @bar2<0
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		elsif @bar2 > @bar1 && @bar2 > @bar3
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		elsif @bar5>=1 && @bar4>=1 && @bar3>=1 && @bar2>=1 && @bar1>=1	# to display reviews, each star at least 1
			@pct5 = (@bar5.fdiv(num)*100).round(1)
			@pct4 = (@bar4.fdiv(num)*100).round(1)
			@pct3 = (@bar3.fdiv(num)*100).round(1)
			@pct2 = (@bar2.fdiv(num)*100).round(1)
			@pct1 = (@bar1.fdiv(num)*100).round(1)
			return @pct5, @pct4, @pct3, @pct2, @pct1, @bar5, @bar4, @bar3, @bar2, @bar1
		else
			random_barchart(num, a1, a2, b1, b2 ,c1, c2, d1, d2, e1, e2)
		end
	end

	def index
	end

	def new
  	@subject = Subjectinfo.new
	end

	def create
		@subject = Subjectinfo.new(params[:subjectinfo])

		@subject_mobile = params[:subjectinfo][:mobile_user]
		@subject_visit = params[:subjectinfo][:visit_frequency]
		@subject_previous = params[:subjectinfo][:previous_experience]
		
		# terminate, not mobile user, unknow visit frequency, expert in health & fitness
		if (@subject_mobile=="0" ||  (@subject_visit=="5" || @subject_visit=="6") || (@subject_previous=="6" || @subject_previous=="7"))
			flash[:notice] = "We’re sorry. You do not meet the qualifications for this survey. We are seeking respondents who are mobile device user AND have experience of using app store. We sincerely thank you and appreciate your time, dedication, and continued participation in our online surveys."
			redirect_to :action => :index and return
		else
			@subject.save
		end

		if @subject.save

			@subject_esearch = params[:subjectinfo][:esearch]
			@subject_id = Subjectinfo.find_by_esearch(@subject_esearch)

		# create random seeds
		# regulatory focus, 0 for promotion, 1 for prevention
		@rf_seed = Random.rand(2)

		# app name, app description
		@name_seed = [1,2,3,4,5,6,7,8].shuffle

		# app icon, app screenshot
		@icon_seed = [1,2,3,4,5,6,7,8].shuffle

		# app description
		@description_seed = [1,2,3,4,5,6,7,8].shuffle

		# app screenshot
		@screenshot_seed = [1,2,3,4,5,6,7,8].shuffle

		# number of ratings, 0 for 20-50, 1 for 1000-5000
		# @num = Random.rand(2)
		@num_seed = [0,0,0,0,1,1,1,1].shuffle

		# rating distribution shape, 0 for J shaped, 1 for U shaped
		# @distr = Random.rand(2)
		@distr_seed = [0,0,0,0,1,1,1,1].shuffle

		# rating distribution shape detail, 3 shapes for J or U
		@barchart_seed = 8.times.map {Random.rand(3)}


		# create random content and store to database
		# regulatory focus
		if @rf_seed == 0
			@rf = "promotion"
		elsif @rf_seed == 1
			@rf = "prevention"
		end

		(0..7).each do |i|	# select which to be the (i+1)-th, (i+1) is app order
			@name = Realapp.find(@name_seed[i])	
			@icon = Realapp.find(@icon_seed[i])
			@description = Realapp.find(@description_seed[i])	
			@screenshot = Realapp.find(@screenshot_seed[i])

			# number of ratings
			if @num_seed[i] == 0
				@num = 20 + Random.rand(30)
			elsif @num_seed[i] == 1
				@num = 1000 + Random.rand(4000)
			end

			# rating distribution shape
			# rating distribution shape detail, 3 shapes for J or U
			if @distr_seed[i] == 0
				@distr = "J"
				case @barchart_seed[i]
					when 0
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 60, 80, 10, 20, 10, 15, 5, 15, 10, 20)
					when 1
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 60, 80, 30, 50, 10, 15, 5, 15, 10, 20)
					when 2
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 60, 80, 20, 40, 10, 15, 5, 15, 10, 30)
				end
			elsif @distr_seed[i] == 1
				@distr = "U"
				case @barchart_seed[i]
					when 0
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 70, 90, 10, 20, 10, 20, 10, 20, 65, 75)
					when 1
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 70, 90, 25, 40, 10, 20, 1, 20, 65, 75)
					when 2
						@pct_star5, @pct_star4, @pct_star3, @pct_star2, @pct_star1, @bar_star5, @bar_star4, @bar_star3, @bar_star2, @bar_star1 = random_barchart(@num, 70, 90, 20, 40, 10, 20, 20, 40, 65, 75)
				end
			end

			# calculate average rating
			@average = ((5*@bar_star5 + 4*@bar_star4 + 3*@bar_star3 + 2*@bar_star2 + 1*@bar_star1).fdiv(@num)).round(1)

			Mockupapp.create(:esearch => @subject_esearch, :regulatoryfocus => @rf,
										:apporder => i+1, :appname => @name.name, :description => @description.description,
										:icon => @icon.icon,
										:screenshot1 => @screenshot.screenshot1, :screenshot2 => @screenshot.screenshot2, :screenshot3 => @screenshot.screenshot3,
										:averagerating => @average, :totalrating => @num, :distribution => @distr,
										:num_star5 => @bar_star5, :num_star4 => @bar_star4, :num_star3 => @bar_star3,
										:num_star2 => @bar_star2, :num_star1 => @bar_star1,
										:pct_star5 => @pct_star5, :pct_star4 => @pct_star4, :pct_star3 => @pct_star3,
										:pct_star2 => @pct_star2, :pct_star1 => @pct_star1,
										:price => "0.99", :subjectinfo_id => @subject_id.id)

			@subject.update_attributes!(:regulatoryfocus => @rf)
		end # end for loop


		# app reviews
		# review display order
		@review_seed = [1,2,3,4,5].shuffle
		# review_star_seed[4][0] is star5 refer to (review_star_seed[4][0])-th review
		@review_star_seed = [[1,2,3,4,5,6,7,8].shuffle,[1,2,3,4,5,6,7,8].shuffle,[1,2,3,4,5,6,7,8].shuffle,[1,2,3,4,5,6,7,8].shuffle,[1,2,3,4,5,6,7,8].shuffle]

		for i in 0..7	# select which to be the (i+1)-th, (i+1) is app order
			@app = Mockupapp.where("esearch=? AND apporder=?",@subject_esearch,i+1)
			for j in 0..4
				review_star = Review.where("star=?",j+1)
				# there are review_star[0] - review_star[7]
				@review = review_star[@review_star_seed[j][i]-1]

				Mockupreview.create(:esearch => @app[0].esearch, :apporder => @app[0].apporder, :appname => @app[0].appname,
											:revieworder => @review_seed[j],
											:star => @review.star,:title => @review.title,:author => @review.author,:content => @review.content,
											:date => @review.date, :mockupapp_id => @app[0].id)
			end # end for loop j
		end # end for loop i

		  redirect_to :action => "rfscenario", :id => @subject_esearch
		else # not pass DB validation
		  render :action => :new # might have problem on view's radio checkbox
		end
	end

	def rfscenario
		@subject_esearch = params[:id]
		@subject = Subjectinfo.find_by_esearch(@subject_esearch)
	end

	def applist
		@subject_esearch = params[:id]
		@app = Mockupapp.where(:esearch => @subject_esearch)
	end

	def detail
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
	end

	def review
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@app = Mockupapp.find_by_esearch(@subject_esearch, :conditions => "apporder = #{@app_order}")
		@appreview= Mockupreview.where("esearch=? AND apporder=?", @subject_esearch, @app_order).order("revieworder ASC")
	end

	def survey
		@subject_esearch = params[:esearch]
		@app_order = params[:apporder]
		@esearch = Subjectinfo.find_by_esearch(@subject_esearch)
  	@subject = Survey.new
	end

	def endsurvey
		@esearch = Subjectinfo.find_by_esearch(params[:survey][:esearch])

		@subject = Survey.new(params[:survey])
		@subject.save
		if @subject.save
			flash[:notice] = "Your response has been recorded."
		  render :action => "thankyou"
		else # not pass DB validation
		  render :action => :survey, :esearch => params[:survey][:esearch]
		end
	end

	def thankyou
	end

end # end class
