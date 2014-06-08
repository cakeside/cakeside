class AddSha256ToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :sha256, :string
  end
end
