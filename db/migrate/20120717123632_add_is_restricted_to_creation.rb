class AddIsRestrictedToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :is_restricted, :boolean, :default => false, :null => false
  end
end
