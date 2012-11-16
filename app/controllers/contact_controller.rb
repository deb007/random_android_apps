class ContactController < ApplicationController
  skip_before_filter :prepare_session, :checksession

	def index
		@include_skin = "plastic"

		@include_nivo_slider = TRUE
		@include_pretty_photo = TRUE
		@include_superfish = TRUE
		@include_poshytip = TRUE
		@include_tweet = TRUE
		@include_fancybox = TRUE

		@breadcrumb = Array.new
		@breadcrumb << "Home|index"
		@breadcrumb << "Contact"

		@page_title = "Contact Us"

	end
end
