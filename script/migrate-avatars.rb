#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

BlobStorage.new.tap do |blob_storage|
  Avatar.includes(:user).where('avatar IS NOT NULL').find_each do |avatar|
    begin
      key = avatar.avatar.path
      blob_storage.download(key) do |file|
        puts file.path
        UploadAvatar.new.run(avatar.user, OpenStruct.new(path: file.path, original_filename: File.basename(key), content_type: 'image/jpeg'))
      end
    rescue StandardError => error
      puts error.message
    end
  end
end
