class Photo < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| model.creation.user }
  attr_accessible :is_primary, :creation, :image
  belongs_to :creation, :counter_cache => true
  validates :image,  :presence => true
  mount_uploader :image, PhotoUploader
  process_in_background :image
  #store_in_background :image

  include Rails.application.routes.url_helpers
  def to_jq_upload
    if image.thumb.url && image.thumb.url != image.thumb.default_url
      {
        :name => read_attribute(:image),
        :size => image.size,
        :url => image.url,
        :thumbnail_url => image.thumb.url,
        :delete_url => id,
        :delete_type => "DELETE"
      }
    else
      {
        :name => read_attribute(:image),
        :size => image.size,
        :url => image.url,
        :thumbnail_url => image.url,
        :delete_url => id,
        :delete_type => "DELETE"
      }
    end
  end

  def watermark
    creation.watermark
  end
end
