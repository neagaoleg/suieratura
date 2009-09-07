class CreateUserImage < ActiveRecord::Migration
  def self.up
  	add_column :projimages, :user_id, :integer
    add_column :projimages, :primary, :boolean
    add_column :projimages, :created_at, :datetime
  end

  def self.down
  	remove_column :projimages, :user_id
    remove_column :projimages, :primary
    remove_column :projimages, :created_at
  end
end
