class AddIndexes < ActiveRecord::Migration
  def up
    add_index(:photos, :creation_id)
    add_index(:creations, :created_at)
  end

  def down
  end
end
