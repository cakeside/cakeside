class RenameLikesToFavorites < ActiveRecord::Migration
  def change
    rename_table :likes, :favorites
  end
end
