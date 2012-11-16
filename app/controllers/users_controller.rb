class UsersController < ApplicationController
  skip_before_filter :prepare_session, :checksession

  def index
    if not session[:userid]
			session[:referer] = request.url
			redirect_to :controller => "users", :action => "register"
    else
    end
  end

  def register
    if session[:userid]
      redirect_to root_path
    else
      @user = User.new
      @include_skin = "plastic"

      @include_nivo_slider = TRUE
      @include_pretty_photo = TRUE
      @include_superfish = TRUE
      @include_poshytip = TRUE
      @include_tweet = TRUE
      @include_fancybox = TRUE

      @breadcrumb = Array.new
      @breadcrumb << "Home|/"
      @breadcrumb << "Register"

      @page_title = "Register"

    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        #Emails.welcome_email(@user).deliver
        format.html { redirect_to(root_url, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @index }
      else
        format.html { render :action => "register" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end

  end

  def login
      @include_skin = "plastic"

      @include_nivo_slider = TRUE
      @include_pretty_photo = TRUE
      @include_superfish = TRUE
      @include_poshytip = TRUE
      @include_tweet = TRUE
      @include_fancybox = TRUE

      @breadcrumb = Array.new
      @breadcrumb << "Home|/"
      @breadcrumb << "Login"

      @page_title = "Login"
      @page_subtitle = "to CrickU"

  end

  def forgot_password
    if request.post?
      u= User.find_by_mail(params[:user][:mail])
      if u and u.send_new_password
        flash[:warning]  = "A new password has been sent by email."
        redirect_to index_index_path
      else
        flash[:warning]  = "Password could not be sent"
        redirect_to root_path
      end
    else
      @user = User.new
      @forgot_page = TRUE
    end
  end

  def change_password
    @user = User.find_by_id(session[:userid])
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:warning]="Password Changed"
      end
    end
  end

  def confirm
    confirm = params[:confirm]
    u = User.find(:first, :conditions=>["mail = ?", params[:email]])
    if u.nil?
      flash[:warning]="Email address could not be confirmed"
      redirect_to root_path
    else
      if User.encrypt(params[:email], u.salt)==confirm
        u.update_attributes(:status => 0)
        u.save(:validate => false)
        flash[:warning]="Email address is now confirmed. Please login."
        redirect_to root_path
      else
        flash[:warning]="Email address could not be confirmed"
        redirect_to root_path
      end
    end
  end

  def hover
    @user = User.find_by_user_id(params[:id])
    @follower_status = Follower.check(params[:id],session[:username])
    if @favorites.nil?
      @favorites    = Favorite.favorite_list(session[:userid])
    end
    render :partial => 'users/user_hover'
  end

  def approve
    @user = User.find_by_id(params[:id])
    @user.update_attributes(:status=>'1')
    if @user.save(:validate=>false)
      redirect_to :back
    end
  end

  def block
    @user = User.find_by_id(params[:id])
    @user.update_attributes(:status=>'2')
    if @user.save(:validate=>false)
      redirect_to :back
    end
  end
end
