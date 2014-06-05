class Photo < ActiveRecord::Base
  belongs_to :creation, counter_cache: true, touch: true
  #mount_uploader :image, PhotoUploader

  #def thumb_url
    #image.thumb.url
  #end

  def watermark
    return '' if creation.nil?
    creation.watermark
  end

  def is_processed?
    !self.image_processing
  end

  def upload(file, blob_storage)
    image = Image.new(file)
    versions.each do |version|
      version.upload(image, blob_storage)
    end
  end

  def create_key(prefix = '')
    "uploads/photo/image/#{id}/#{prefix}#{original_filename}"
  end

  private

  def versions
    @versions ||= [OriginalVersion.new(self), LargeVersion.new(self), ThumbnailVersion.new(self)]
  end

  class OriginalVersion
    def initialize(photo)
      @photo = photo
    end

    def upload(image, blob_storage)
      blob_storage.upload(@photo.create_key, image.path)
    end
  end

  class LargeVersion
    def initialize(photo)
      @photo = photo
    end

    def upload(image, blob_storage)
      image.resize_to_fit(570, 630)
      blob_storage.upload(@photo.create_key('large_'), image.path)
    end
  end

  class ThumbnailVersion
    def initialize(photo)
      @photo = photo
    end

    def upload(image, blob_storage)
      image.resize_to_fill(260, 180)
      blob_storage.upload(@photo.create_key('thumb_'), image.path)
    end
  end
end
