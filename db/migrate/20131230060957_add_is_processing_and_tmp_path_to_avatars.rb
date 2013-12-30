class AddIsProcessingAndTmpPathToAvatars < ActiveRecord::Migration
  def change
    add_column :avatars, :avatar_processing, :boolean
    add_column :avatars, :avatar_tmp, :string
  end
end
