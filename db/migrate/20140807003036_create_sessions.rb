class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions, id: :uuid do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
