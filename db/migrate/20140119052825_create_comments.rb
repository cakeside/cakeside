class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :creation_id
      t.string :text
      t.integer :disqus_id
    end

    add_index :comments, :user_id
    add_index :comments, :creation_id
  end
end
