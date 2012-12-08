class IndexController < ApplicationController

	def index
		@include_skin = "plastic"

		@homepage = TRUE
		@include_nivo_slider = TRUE
		@include_tabs = TRUE
		@include_pretty_photo = TRUE
		@include_superfish = TRUE
		@include_poshytip = TRUE
		@include_tweet = TRUE
		@include_fancybox = TRUE

		@headline_text = TRUE

		@breadcrumb = Array.new
		@breadcrumb << "Home|index.html"
		@breadcrumb << " "

		@page_title = "Welcome"
		@page_subtitle = "to #{Rails.application.class.parent_name}"

		@random_free_apps = Apps.find(:all, :select=>"*", :conditions=>"", 
				:joins=> 'LEFT JOIN app_categories ON app_categories.app_id=apps.id', :order => 'random()', :limit => 10)

		
	end
end
