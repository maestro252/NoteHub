class RemoveFriendFromEvent < ActiveRecord::Migration
  def change
  	remove_column :events, :friend_id
  end
end
