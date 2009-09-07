class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User", :foreign_key => "friend_id"
	
	validates_presence_of :user_id, :friend_id
  
	def self.are_friends(user, friend)
       return false if user == friend
       return true unless find_by_user_id_and_friend_id(user, friend).nil?
       return true unless find_by_user_id_and_friend_id(friend, user).nil?
       false
    end
	
    def self.request(user, friend)
       return false if are_friends(user, friend)
       return false if user == friend
       f1 = new(:user => user, :friend => friend, :status => "pending")
       f2 = new(:user => friend, :friend => user, :status => "requested")
       transaction do
          f1.save
          f2.save
       end
       return true
    end
    
    def self.accept(user, friend)
       f1 = find_by_user_id_and_friend_id(user, friend)
       f2 = find_by_user_id_and_friend_id(friend, user)
       if f1.nil? or f2.nil?
       return false
    else
       transaction do
          f1.update_attributes(:status => "accepted")
          f2.update_attributes(:status => "accepted")
       end
       end
       return true
    end
    
    def self.reject(user, friend)
    f1 = find_by_user_id_and_friend_id(user, friend)
    f2 = find_by_user_id_and_friend_id(friend, user)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.destroy
        f2.destroy
        return true
      end
    end
  end
      
end
