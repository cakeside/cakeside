class RenameLikesToFavorites < ActiveRecord::Migration
  def change
    rename_table :like, :favorite
  end
end
