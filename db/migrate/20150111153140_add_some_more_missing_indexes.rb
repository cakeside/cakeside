class AddSomeMoreMissingIndexes < ActiveRecord::Migration
  def change
    add_index :locations, [:locatable_id, :locatable_type]
    add_index :photos, [:imageable_id, :imageable_type]
    add_index :creations, :category_id
    add_index :categories, :slug
  end
end
