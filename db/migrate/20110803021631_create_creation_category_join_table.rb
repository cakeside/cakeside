class CreateCreationCategoryJoinTable < ActiveRecord::Migration
  def self.up
    create_table :creations_categories, :id => false do |t|
      t.integer :creation_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :creations_categories
  end
end
