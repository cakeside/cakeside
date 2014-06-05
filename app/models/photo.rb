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
    upload_original(image)
  end

  private

  def upload_original(image, blob_storage)
    blob_storage.upload(create_key, image.path)
    upload_large_version(image, blob_storage)
  end

  def upload_large_version(image, blob_storage)
    image.resize_to_fit(570, 630)
    blob_storage.upload(create_key('large'), image.path)
    upload_thumbnail_version(image, blob_storage)
  end

  def upload_thumbnail_version(image, blob_storage)
    image.resize_to_fill(260, 180)
    blob_storage.upload(create_key('thumb'), image.path)
  end

  def create_key(prefix = '')
    "uploads/photo/image/#{id}/#{prefix}_#{original_filename}"
  end
end
