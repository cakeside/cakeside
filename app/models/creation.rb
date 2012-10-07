class Creation < ActiveRecord::Base
  acts_as_commentable
  validates :name,  :presence => true
  attr_accessible :user_id, :story, :name, :category_ids, :is_restricted, :watermark
  belongs_to :user
  has_and_belongs_to_many :categories, :join_table => 'creations_categories', :uniq => true, :autosave => true
  has_many :photos, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  default_scope order("created_at DESC")

  def short_story
    story.split[0...50].join(' ') + '...'
  end

  def is_owned_by(user)
    @user == user
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def has_comments
    self.comment_threads.length > 0
  end

  def primary_image
    photos.first
  end

  def main_image_thumb_url
    primary_image.image.thumb.url
  end
end
