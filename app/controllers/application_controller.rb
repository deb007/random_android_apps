class ApplicationController < ActionController::Base
  protect_from_forgery
  	before_filter :set_default
	#before_filter :prepare_session, :checksession, :except => [:notify, :upload_data]

	def set_default

		@include_skin = "plastic"

		@include_nivo_slider = FALSE
		@include_pretty_photo = TRUE
		@include_superfish = TRUE
		@include_poshytip = TRUE
		@include_tweet = FALSE
		@include_fancybox = TRUE

		@game_cat = Category.where("id <= 8")
		@app_cat = Category.where("id > 8 and id < 100")

	end

	def prepare_session

		if !session[:expiry_time].nil? and session[:expiry_time] < Time.now
			reset_session
			redirect_to :controller => "users", :action => "login"
		end
		session[:expiry_time] = (60 * 60).seconds.from_now
		return true
	end

	def checksession
		if not session[:userid]
			session[:referer] = request.url
			redirect_to :controller => "users", :action => "login"
		end
	end

	def hash_with_default_hash
    Hash.new { |hash, key| hash[key] = hash_with_default_hash }
	end

	def is_numeric(val)
		true if Float(val) rescue false
	end

end
