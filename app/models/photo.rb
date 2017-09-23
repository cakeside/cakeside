class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true, counter_cache: true, touch: true
  scope :processed, ->{ where(image_processing: nil) }

  def url_for(version_key, asset_host = ENV['ASSET_HOST'])
    version(version_key).url_for(asset_host)
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
      blob_storage.upload(version.blob_key, image.path)
    end
  end

  def version(key)
    versions.detect { |version| version.for?(key) }
  end

  private

  def versions
    @versions ||= [OriginalVersion.new(self), LargeVersion.new(self), ThumbnailVersion.new(self)]
  end
end
