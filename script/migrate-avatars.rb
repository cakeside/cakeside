#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

BlobStorage.new.tap do |blob_storage|
  Avatar.includes(:user).where('avatar IS NOT NULL').find_each do |avatar|
    begin
      key = avatar.avatar.path
      blob_storage.download(key) do |file|
        puts file.path
        UploadAvatar.new.run(avatar.user, { photo: { image: file.path } })
      end
    rescue StandardError => error
      puts error.message
    end
  end
end
