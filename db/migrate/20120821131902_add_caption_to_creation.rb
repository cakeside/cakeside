class AddCaptionToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :caption, :string
  end
end
