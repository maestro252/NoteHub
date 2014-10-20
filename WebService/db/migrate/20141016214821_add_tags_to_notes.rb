class AddTagsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :tags, :string
    add_index :notes, ['tags'], name: "tags_index"
  end
end
