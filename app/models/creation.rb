class Creation < ActiveRecord::Base
  validates :name,  :presence => true
  belongs_to :user, :counter_cache => true
  belongs_to :category
  has_many :photos, -> { order :created_at }, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :comments, dependent: :destroy
  acts_as_taggable
  alias_method :author, :user

  default_scope -> { order(:created_at => :desc) }

  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def primary_image
    photos.any? ? photos.sample : Photo.new
  end

  def published?
    photos.count > 0
  end

  def is_safe_for_children?
    is_restricted == false
  end

  def is_liked_by(user)
    favorites.where(user: user).any?
  end

  def liked_by(user)
    favorites.find_or_create_by(user: user)
  end
end
