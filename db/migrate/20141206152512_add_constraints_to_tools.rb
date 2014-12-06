class AddConstraintsToTools < ActiveRecord::Migration
  def change
    change_column :tools, :name, :string, null: false
    change_column :tools, :asin, :string, null: false
    add_index :tools, :name, unique: true
    add_index :tools, :asin
  end
end
