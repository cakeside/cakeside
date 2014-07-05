class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  after_create :send_welcome_email

  validates :name,  :presence => true
  validates :website, :format => URI::regexp(%w(http https)), :allow_blank => true
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :tutorials, :dependent => :destroy
  has_many :activities
  has_many :comments
  has_and_belongs_to_many :interests, :join_table => 'users_interests', :autosave => true
  has_one :avatar
  acts_as_tagger

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

  def is_admin?
   self.is_admin
  end

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
    Subscription.delay.subscribe(email: email, first_name: name, last_name: '')
  end

  def recent_activities(limit = 20)
    activities.includes(:subject).order(created_at: :desc).limit(limit)
  end

  def comment_on(creation, text, disqus_id)
    creation.comments.create(text: text, user: self, disqus_id: disqus_id)
  end

  def favorite_cakes
    favorites.includes(:creation).map {|f| f.creation }
  end

  def create_cake(name:, description: nil, category:)
    creations.create(name: name, story: description, category_id: category.id)
  end

  class << self
    def ordered
      User.order(:creations_count => :desc)
    end
  end
end
