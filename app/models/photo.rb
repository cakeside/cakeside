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

  class Version
    attr_reader :key, :prefix, :photo

    def initialize(photo, key, prefix)
      @key = key
      @prefix = prefix
      @photo = photo
    end

    def adjust(image)
      fail "Please override with version specific behaviours"
    end

    def for?(other_key)
      key == other_key
    end

    def url_for(asset_host)
      if photo.is_processed?
        "#{asset_host}/#{create_key}"
      else
        ActionController::Base.helpers.asset_path("#{key}_default.png")
      end
    end

    def create_key
      "uploads/photo/image/#{photo.id}/#{prefix}#{photo.image}"
    end
  end

  class OriginalVersion < Version
    def initialize(photo)
      super(photo, :original, "")
    end

    def adjust(image); end
  end

  class LargeVersion < Version
    def initialize(photo)
      super(photo, :large, "large_")
    end

    def adjust(image)
      image.resize_to_fit(570, 630)
    end
  end

  class ThumbnailVersion < Version
    def initialize(photo)
      super(photo, :thumb, "thumb_")
    end

    def adjust(image)
      image.resize_to_fill(260, 180)
    end
  end
end
