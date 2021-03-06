class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
 # in_place_edit_for :current_user, :email
  
  def index
  	@search = User.search(params[:search],params[:page])
    #@search.all
  	#@users = User.find(:all)
  	#@users = User.paginate :page => params[:page], :per_page => 2
  	#@users = User.paginate_by_user_id @user.id, :page => params[:page], :order => 'updated_at DESC'
  end

  def show  	
    @users = User.find(:all)
    @users = User.paginate :page => params[:page], :order => 'updated_at DESC'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to(users_url)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Your query was successfully updated.'
      redirect_to(users_path)
    else
      render :action => 'edit'
    end
  end

  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

end
