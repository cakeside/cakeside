class AddMoreMissingIndexes < ActiveRecord::Migration
  def change
    add_index :taggings, :taggable_type
    add_index :taggings, :tagger_type
  end
end
