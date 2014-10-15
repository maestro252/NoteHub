class AddPatternToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :pattern, :string
  end
end
