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

		@random_free_apps = AppRank.find(:all, :select=>"*", :conditions=>"", :joins=> 'LEFT JOIN apps ON app_ranks.app_id=apps.id', 
			:group => 'apps.id', :order => 'random()', :limit => 10)

		
	end
end
