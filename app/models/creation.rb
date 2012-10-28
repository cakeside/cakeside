class Creation < ActiveRecord::Base
  acts_as_commentable
  validates :name,  :presence => true
  attr_accessible :user_id, :story, :name, :category_ids, :is_restricted, :watermark, :image
  belongs_to :user
  has_and_belongs_to_many :categories, :join_table => 'creations_categories', :uniq => true, :autosave => true
  has_many :photos, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  # to be removed after migration
  mount_uploader :image, ImageUploader

  default_scope order("created_at DESC")

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def has_comments
    self.comment_threads.length > 0
  end

  def primary_image
    if photos.any?
      photos.where(:is_primary => true).first
    else
      Photo.new
    end
  end

  def migrate_primary_image
      photo = photos.build({:is_primary => true})
      photo.created_at = created_at
      photo.updated_at = updated_at
      photo.image = image.file
      photo.save!
  end

  def publish
    self.update_attribute(:is_published, true)
    self.save!
  end
end
