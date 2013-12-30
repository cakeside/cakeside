class Photo < ActiveRecord::Base
  belongs_to :creation, :counter_cache => true
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  #process_in_background :image
  store_in_background :image

  def to_jq_upload
    {
      :name => read_attribute(:image),
      :url => image.url,
      :thumbnail_url => is_processed? ? image.thumb.url : image.url,
      :delete_url => id,
      :delete_type => "DELETE"
    }
  end

  def watermark
    creation.watermark
  end

  private

  def is_processed?
    self.image_processing
  end
end
