class Photo < ActiveRecord::Base
  belongs_to :creation, counter_cache: true, touch: true
  #mount_uploader :image, PhotoUploader

  def watermark
    return '' if creation.nil?
    creation.watermark
  end

  def is_processed?
    !self.image_processing
  end

  def upload(file, blob_storage)
    image = Image.new(file)
    self.original_filename = image.filename
    versions.each do |version|
      version.adjust(image)
      blob_storage.upload(create_key(version.prefix), image.path)
    end
  end

  private

  def create_key(prefix = '')
    "uploads/photo/image/#{id}/#{prefix}#{original_filename}"
  end

  def versions
    @versions ||= [OriginalVersion.new, LargeVersion.new, ThumbnailVersion.new]
  end

  class OriginalVersion
    attr_reader :prefix

    def initialize
      @prefix = ''
    end

    def adjust(image); end
  end

  class LargeVersion
    attr_reader :prefix

    def initialize
      @prefix = 'large_'
    end

    def adjust(image)
      image.resize_to_fit(570, 630)
    end
  end

  class ThumbnailVersion
    attr_reader :prefix

    def initialize
      @prefix = 'thumb_'
    end

    def adjust(image)
      image.resize_to_fill(260, 180)
    end
  end
end
