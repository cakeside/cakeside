class Creation < ActiveRecord::Base
  validates :name, presence: true
  validates :category_id, presence: true
  belongs_to :user, counter_cache: true
  belongs_to :category
  has_many :photos, -> { order :created_at }, dependent: :destroy, as: :imageable
  has_many :favorites, :dependent => :destroy
  has_many :comments, dependent: :destroy
  acts_as_taggable_on :tags
  alias_method :author, :user

  default_scope -> { order(created_at: :desc) }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def primary_image
    published? ? photos.sample : Photo.new
  end

  def published?
    photos.any?
  end

  def is_liked_by(user)
    favorites.where(user: user).any?
  end

  def liked_by(user)
    favorites.find_or_create_by(user: user)
  end
end
