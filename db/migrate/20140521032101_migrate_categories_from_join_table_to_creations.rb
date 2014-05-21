class MigrateCategoriesFromJoinTableToCreations < ActiveRecord::Migration
  def up
    execute("UPDATE creations AS c SET category_id = cat.category_id FROM creations_categories AS cat WHERE c.id = cat.creation_id")
  end

  def down
  end
end
