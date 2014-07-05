class AddWatermarkToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :watermark, :string
  end
end
