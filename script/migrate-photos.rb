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
      begin
        original = OriginalVersion.new(photo)
        key = original.create_key
        puts "processing #{key}"
        storage.download(key) do |file|
          bus.publish(:upload_photo, {
            photo_id: photo.id,
            file_path: move_to_temporary_storage(file.path, File.basename(key))
          })
        end
      rescue StandardError => error
        puts error.message
      end
    end
  end

  private

  def move_to_temporary_storage(temp_file_path, original_filename)
    "#{create_tmp_dir}/#{original_filename}".tap do |new_path|
      FileUtils.mv(temp_file_path, new_path)
    end
  end

  def create_tmp_dir
    Rails.root.join("tmp/uploads/#{SecureRandom.uuid}").tap do |directory|
      system "mkdir -p #{directory}"
    end
  end
end

Command.new.run
