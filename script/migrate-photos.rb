#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

class Command
  attr_reader :bus, :storage

  def initialize(message_bus = Spank::IOC.resolve(:message_bus), storage = BlobStorage.new)
    @bus = message_bus
    @storage = storage
  end

  def run
    Photo.find_each do |photo|
      original = OriginalVersion.new(photo)
      storage.download(original.create_key) do |file|
        message_bus.publish(:upload_photo, {
          photo_id: photo.id,
          file_path: move_to_temporary_storage(file.path, File.basename(original.create_key))
        })
      end
    end
  end

  private

  def move_to_temporary_storage(temp_file_path, original_filename)
    "#{create_tmp_dir}/#{original_filename}".tap do |new_path|
      FileUtils.mv(temp_file_path, new_path)
    end
  end
end

Command.new.run
