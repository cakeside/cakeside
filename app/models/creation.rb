class Creation < ActiveRecord::Base
  validates :name,  :presence => true
  validates :image,  :presence => true
  attr_accessible :user_id, :story, :name, :image, :remote_image_url
  belongs_to :user
  has_and_belongs_to_many :categories, :join_table => 'creations_categories', :uniq => true, :autosave => true
  mount_uploader :image, ImageUploader

  define_index do
    indexes :name, :sortable => true
    indexes story
  end

  def short_story
    story.split[0...50].join(' ') + '...'
  end

end
