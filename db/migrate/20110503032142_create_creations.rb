class CreateCreations < ActiveRecord::Migration
  def self.up
    create_table :creations do |t|
      t.string :name
      t.text :story

      t.timestamps
    end
  end

  def self.down
    drop_table :creations
  end
end
