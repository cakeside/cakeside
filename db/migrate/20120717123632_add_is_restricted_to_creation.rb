class AddIsRestrictedToCreation < ActiveRecord::Migration
  def change
    add_column :creations, :is_restricted, :boolean, :default => false, :null => false
    Creation.joins(:categories).where(:categories => {:slug => 'Naughty Cakes'}).each do |creation|
      creation.update_attributes! :is_restricted => true
    end
  end
end
