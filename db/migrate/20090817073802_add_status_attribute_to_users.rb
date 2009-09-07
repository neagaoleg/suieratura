class AddStatusAttributeToUsers < ActiveRecord::Migration
  def self.up
  	add_column :friendships, :status, :string
  	@friendships = Friendship.find(:all)
  	@friendships.each do |friendship|
  		friendship.update_attribute(:status, 'pending')
  	end
  end

  def self.down
  	remove_column :friendships, :status
  end
end
