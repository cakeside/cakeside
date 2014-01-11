class Creation < ActiveRecord::Base
  validates :name,  :presence => true
  belongs_to :user, :counter_cache => true
  has_and_belongs_to_many :categories, :join_table => 'creations_categories', :autosave => true
  has_many :photos, -> { order :created_at }, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  acts_as_taggable

  default_scope -> { order(:created_at => :desc) }

  def to_param
    "#{id}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def primary_image
    photos.any? ? photos.first : Photo.new
  end

  def published?
    photos.count > 0
  end

  def is_safe_for_children?
    is_restricted == false
  end

  def add_photo(photo)
    photos.create(:image => photo)
  end

  def is_liked_by(user)
    favorites.any? { |favorite| favorite.user == user }
  end

  def liked_by(user)
    if is_liked_by(user)
      favorites.find { |favorite| favorite.user == user }
    else
      favorites.create({:user_id => user.id})
    end
  end

  class << self
    def search(query)
      sql_search = "%#{query}%"
      Creation.where("upper(name) like upper(?) OR upper(story) like upper(?)", sql_search, sql_search)
    end

    def visible_creations
      Creation.distinct.includes(:user).joins(:photos).where(is_restricted: false, 'photos.image_processing' => nil)
    end
  end
end
