class AddUsernameToNote < ActiveRecord::Migration
  def change
    add_column :notes, :username, :string
  end
end
