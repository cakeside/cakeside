class AddIsPublishedToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :is_published, :boolean, :default => false
    Creation.reset_column_information
    Creation.all.each do |p|
      p.update_column :is_published, true
    end
  end
end
