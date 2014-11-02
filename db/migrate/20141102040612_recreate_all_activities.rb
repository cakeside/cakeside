class RecreateAllActivities < ActiveRecord::Migration
  def change
    ActiveRecord::Base.transaction do
      Activity.destroy_all
      Favorite.find_each do |favorite|
        Activity.create(user: favorite.creation.author, subject: favorite, created_at: favorite.created_at, updated_at: favorite.updated_at)
      end
      Comment.find_each do |comment|
        Activity.create(user: comment.creation.author, subject: comment, created_at: comment.created_at, updated_at: comment.updated_at)
      end
    end
  end
end
