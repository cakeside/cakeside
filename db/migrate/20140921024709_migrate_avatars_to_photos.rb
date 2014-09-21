class MigrateAvatarsToPhotos < ActiveRecord::Migration
  def change
    blob_storage = BlogStorage.new
    Avatar.includes(:user).find_each do |avatar|
      user = avatar.user
      key = avatar.avatar.path
      blob_storage.download(key) do |file|
        user.avatar = Photo.create!
        user.avatar.upload(file.path, blob_storage)
        user.avatar.save!
      end
    end
  end
end
