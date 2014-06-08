class Photo < ActiveRecord::Base
  belongs_to :creation, counter_cache: true, touch: true

  def watermark
    return '' if creation.nil?
    creation.watermark
  end

  def url_for(version_key, asset_host = ENV['ASSET_HOST'])
    versions.find { |version| version.for?(version_key) }.url_for(asset_host)
  end

  def is_processed?
    !self.image_processing
  end

  def upload(file, blob_storage)
    image = Image.new(file)
    self.original_filename = File.basename(file)
    self.image = image.filename
    self.content_type = image.content_type
    self.latitude, self.longitude = image.geolocation
    self.image_processing = nil
    self.sha256 = image.sha256
    versions.each do |version|
      version.adjust(image)
      blob_storage.upload(version.create_key, image.path)
    end
  end

  private

  def versions
    @versions ||= [OriginalVersion.new(self), LargeVersion.new(self), ThumbnailVersion.new(self)]
  end
end
