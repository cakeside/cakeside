class AddPhotosCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :photos_count, :integer, default: 0
  end
end
