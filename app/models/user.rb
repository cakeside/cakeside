class User < ActiveRecord::Base
  validates :name,  :presence => true
  validates :website, :format => URI::regexp(%w(http https)), :allow_blank => true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  attr_accessible :name, :email, :website, :twitter, :facebook, :city, :latitude, :longitude, :password, :password_confirmation, :current_password, :remember_me, :interest_ids
  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :tutorials, :dependent => :destroy
  has_and_belongs_to_many :interests, :join_table => 'users_interests', :uniq => true, :autosave => true
  has_one :avatar
  acts_as_tagger
  before_save :ensure_authentication_token
  default_scope order("created_at DESC")

  def add_favorite(creation)
    creation.liked_by(self)
  end

  def already_likes(creation)
    creation.is_liked_by(self)
  end

  def owns(creation)
    creation.user == self
  end

  def comment_on(creation, comment)
    Comment.create_for(self, creation, comment)
  end

  def change_password(password, confirmation)
    return false unless password == confirmation
    self.password = password
    self.save!
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
