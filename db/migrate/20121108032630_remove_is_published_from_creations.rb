class RemoveIsPublishedFromCreations < ActiveRecord::Migration
  def up
    remove_column :creations, :is_published
  end

  def down
    add_column :creations, :is_published, :boolean
  end
end
