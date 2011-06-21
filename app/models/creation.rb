class Creation < ActiveRecord::Base
  validates :name,  :presence => true
  validates :image,  :presence => true
  attr_accessible :user_id, :story, :name, :image, :remote_image_url
  belongs_to :user
  mount_uploader :image, ImageUploader

  define_index do
    indexes :name
    indexes story
  end

  def short_story
    story.split[0...8].join(' ') + '...'
  end

end
