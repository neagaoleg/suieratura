class ProjimagesController < ApplicationController

  def new
    @projimage = Projimage.new
  end
   
  def create
  	sleep(1)
    user_data = {:user_id => current_user, :primary => current_user.projimages.empty? }
    @projimage = Projimage.new(params[:projimage].merge(user_data))
  	
    if @projimage.save
      flash[:notice] = 'Project Image was successfully created.'
      redirect_to edit_user_path(current_user)
    else
      render :action => :new
    end
  end

  def index
    @projimages = Projimage.find(:all, :conditions => "thumbnail is null")
  end

  def show
    @projimage = Projimage.find(params[:id])
  end

end
