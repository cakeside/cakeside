class AddImageUrlToTutorial < ActiveRecord::Migration
  def change
    add_column :tutorials, :image_url, :string
  end
end
