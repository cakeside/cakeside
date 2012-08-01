class Creation < ActiveRecord::Base
  acts_as_commentable
  validates :name,  :presence => true
  validates :image, :presence => true
  attr_accessible :user_id, :story, :name, :image, :remote_image_url, :category_ids, :is_restricted
  belongs_to :user
  has_and_belongs_to_many :categories, :join_table => 'creations_categories', :uniq => true, :autosave => true
  has_many :photos, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  mount_uploader :image, ImageUploader

  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w
  after_update :reprocess_image, :if => :cropping?

  default_scope order("created_at DESC")

  def short_story
    story.split[0...50].join(' ') + '...'
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def profile_geometry
    img = Magick::Image::read('http://cakeside.dev'+self.image_url).first
    @geometry = {:width => img.columns, :height => img.rows }
  end

  def reprocess_image
    begin
      self.image.recreate_versions!
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace.inspect
    end
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
end
