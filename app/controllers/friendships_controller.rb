class FriendshipsController < ApplicationController
  
  def accept
    @user = current_user
    @friend = User.find_by_login(params[:id])
    unless @friend.nil?
      if Friendship.accept(@user, @friend)
        flash[:notice] = "#{@friend.login} accepted"
      else
        flash[:notice] = "#{@friend.login} cannot be accepted"
      end
    end
    redirect_to :controller => :users, :action => :index
  end
  
  def reject
    @user = current_user
    @friend = User.find_by_login(params[:id])
    unless @friend.nil?
      if Friendship.reject(@user, @friend)
        flash[:notice] = "#{@friend.login} rejected"
      else
        flash[:notice] = "#{@friend.login} cannot be rejected"
      end
    end
    redirect_to :controller => :users, :action => :index
  end	
	
  def req
    @user = current_user
    @friend = User.find_by_login(params[:id])
    unless @friend.nil?
      if Friendship.request(@user, @friend)
        flash[:notice] = "#{@friend.login} requested"
      else
        flash[:notice] = "#{@friend.login} cannot be requested"
      end
    end
    redirect_to :controller => :users, :action => :index
  end	
	
  def create  
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])  
    if @friendship.save  
      flash[:notice] = "Added friend."  
      redirect_to root_url  
    else  
      flash[:error] = "Error occurred when adding friend."  
      redirect_to root_url  
    end  
  end  
  
  def destroy  
    @friendship = current_user.friendships.find(params[:id])  
    @friendship.destroy  
    flash[:notice] = "Successfully destroyed friendship."  
    redirect_to root_url  
  end 
end
