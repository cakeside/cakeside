class ProcessPhoto
  def initialize(photos, exif_parser, blob_storage = BlobStorage.new)
    @photos = photos
    @exif_parser = exif_parser
    @blob_storage = blob_storage
  end

  def handles?(event)
    :upload_photo == event
  end

  def handle(message)
    file = File.open(message[:file_path])
    photo = @photos.find(message[:photo_id])
    #photo.image = file
    photo.image_processing = nil
    photo.content_type = message[:content_type]
    photo.original_filename = message[:original_filename]
    photo.latitude, photo.longitude = @exif_parser.parse_geolocation_from(file)
    upload_original(message[:file_path], photo)
    photo.save!
  end

  private

  def upload_original(file, photo)
    key = "uploads/photo/image/#{photo.id}/#{File.basename(file)}"
    @blob_storage.upload(key, file)
    upload_large_version(file, photo)
  end

  def upload_large_version(file, photo)
    key = "uploads/photo/image/#{photo.id}/large_#{File.basename(file)}"
    Image.new(file).resize_to_fit(570, 630)
    @blob_storage.upload(key, file)
  end

end

class Image
  attr_reader :current_path

  def initialize(current_path)
    @current_path = current_path
  end

  def resize_to_fit(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}"
      img = yield(img) if block_given?
      img
    end
  end

  private

  def manipulate!
    image = ::MiniMagick::Image.open(current_path)
    begin
      image = yield(image)
      image.write(current_path)
      image.run_command("identify", current_path)
    ensure
      image.destroy!
    end
  rescue ::MiniMagick::Error, ::MiniMagick::Invalid => e
    default = I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :locale => :en)
    message = I18n.translate(:"errors.messages.mini_magick_processing_error", :e => e, :default => default)
    raise CarrierWave::ProcessingError, message
  end
end
