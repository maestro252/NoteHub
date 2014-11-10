class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :friends, :event_id
  end
end
