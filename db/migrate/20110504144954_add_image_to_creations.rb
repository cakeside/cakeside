class AddImageToCreations < ActiveRecord::Migration
  def self.up
    add_column :creations, :image, :string
  end

  def self.down
    remove_column :creations, :image
  end
end
