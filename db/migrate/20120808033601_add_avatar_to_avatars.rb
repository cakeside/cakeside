class AddAvatarToAvatars < ActiveRecord::Migration
  def change
    add_column :avatars, :avatar, :string
  end
end
