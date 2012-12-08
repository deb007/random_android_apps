class CompaniesController < ApplicationController

	def show
		if !params['id'].present?
			redirect_to root_url
		end

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
		
		@company_name = Companies.find(params['id']).company_name

		@breadcrumb = Array.new
		@breadcrumb << "Home|index.html"
		@breadcrumb << @company_name.capitalize

		@page_title = @company_name

		@random_free_apps = Apps.find(:all, :select=>"*", :conditions=>"company_id = #{params['id']}", 
				:joins=> 'LEFT JOIN app_categories ON app_categories.app_id=apps.id',  :order => 'random()', :limit => 10)

	end

end
