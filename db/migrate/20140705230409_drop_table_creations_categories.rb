class DropTableCreationsCategories < ActiveRecord::Migration
  def change
    drop_table :creations_categories
  end
end
