#!/usr/bin/env ruby
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

class Command
  attr_reader :bus, :storage

  def initialize(message_bus = Spank::IOC.resolve(:message_bus), storage = BlobStorage.new)
    @bus = message_bus
    @storage = storage
  end

  def run
    Photo.unscoped.order(id: :desc).each do |photo|
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

  def move_to_temporary_storage(file_path, original_filename)
    "#{create_tmp_dir(file_path)}/#{original_filename}".tap do |new_path|
      FileUtils.mv(file_path, new_path)
    end
  end

  def create_tmp_dir(file_path)
    sha = Digest::SHA256.file(file_path).to_s
    Rails.root.join("tmp/uploads/#{sha}").tap do |directory|
      system "mkdir -p #{directory}"
    end
  end
end

Command.new.run
