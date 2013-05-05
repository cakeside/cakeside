class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :creations, :user_id
    add_index :creations_categories, [:category_id, :creation_id]
    add_index :creations_categories, [:creation_id, :category_id]
    add_index :taggings, :tagger_id
    add_index :avatars, :user_id
    add_index :comments, :parent_id
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :favorites, :user_id
    add_index :favorites, :creation_id
    add_index :tutorials, :user_id
    add_index :users_interests, [:interest_id, :user_id]
  end
end
