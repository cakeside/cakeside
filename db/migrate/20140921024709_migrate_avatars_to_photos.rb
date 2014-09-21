class MigrateAvatarsToPhotos < ActiveRecord::Migration
  def change
    BlobStorage.new.tap do |blob_storage|
      Avatar.includes(:user).where('avatar IS NOT NULL').find_each do |avatar|
        begin
          user = avatar.user
          key = avatar.avatar.path
          blob_storage.download(key) do |file|
            user.avatar = Photo.create!
            user.avatar.upload(file.path, blob_storage)
            user.avatar.save!
          end
        rescue StandardError => error
          say error.message
        end
      end
    end
  end
end
