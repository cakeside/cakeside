class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.string :heading
      t.text :description
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
