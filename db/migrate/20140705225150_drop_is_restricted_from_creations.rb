class DropIsRestrictedFromCreations < ActiveRecord::Migration
  def change
    remove_column :creations, :is_restricted
  end
end
