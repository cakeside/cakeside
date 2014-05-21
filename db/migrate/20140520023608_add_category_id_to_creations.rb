class AddCategoryIdToCreations < ActiveRecord::Migration
  def change
    add_column :creations, :category_id, :integer
  end
end
