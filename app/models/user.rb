class User < ActiveRecord::Base
  geocoded_by :current_sign_in_ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude do |user,results|
    if geo = results.first
      user.full_address = geo.formatted_address
    end
  end

  before_save :geocode, :reverse_geocode
  validates :name,  :presence => true
  validates :website, :format => URI::regexp(%w(http https)), :allow_blank => true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :tutorials, :dependent => :destroy
  has_and_belongs_to_many :interests, :join_table => 'users_interests', :autosave => true
  has_one :avatar
  acts_as_tagger
  before_save :ensure_authentication_token

  def add_favorite(creation)
    creation.liked_by(self)
  end

  def already_likes(creation)
    creation.is_liked_by(self)
  end

  def owns(creation)
    creation.user == self
  end

  def change_password(password, confirmation=password)
    return false unless password == confirmation
    self.password = password
    self.save
  end

  def has_avatar?
    self.avatar && self.avatar.avatar.present?
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def self.ordered
    User.order(:creations_count => :desc)
  end
end
