class CategoriesController < ApplicationController

	def import
		results = Array.new
		a = Mechanize.new { |agent|
			agent.user_agent_alias = 'Mac Safari'
		}

		a.get('https://play.google.com/store') do |page|

			page.search(".category-item").each do |category|
				href = category.first_element_child['href']
				href = href.split('?').first.split('/').last.strip
				Category.create(:category_name=>category.first_element_child.text.strip, :category_id=> href)
			end
		end

		render :text => "Categories import finished"

	end

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

		@breadcrumb = Array.new
		@breadcrumb << "Home|index.html"
		@breadcrumb << params['id'].capitalize

		@page_title = "Category #{params['id'].capitalize}"

		if params['id'] == 'games'
			c = Category.where("category_id <= 8").first
		elsif params['id'] == 'apps'
			c = Category.where("category_id > 8 and category_id <= 100").first
		else
			c = Category.where("category_id = ?", params['id'].upcase).first
		end
		if !c.present?
			redirect_to root_url
		else
			catid = c.id

			@random_free_apps = Apps.find(:all, :select=>"*", :conditions=>"category_id = #{catid}", 
				:joins=> 'LEFT JOIN app_categories ON app_categories.app_id=apps.id',  :order => 'random()', :limit => 10)


		end
	end

end
