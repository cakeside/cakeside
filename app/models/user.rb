class User < ActiveRecord::Base
  has_secure_password
  before_save :ensure_authentication_token
  after_create :send_welcome_email unless Rails.env.test?

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :website, format: URI::regexp(%w(http https)), allow_blank: true
  validates_length_of :password, within: 6..20, allow_blank: true

  has_many :creations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tutorials, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_sessions, dependent: :destroy
  has_and_belongs_to_many :interests, join_table: 'users_interests', autosave: true
  has_one :avatar, class_name: 'Photo', as: :imageable
  acts_as_tagger

  def add_favorite(cake)
    return if self.owns(cake)
    cake.liked_by(self)
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
    self.avatar && self.avatar.image.present?
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  def recent_activities(limit = 20)
    activities.includes(subject: [{user: :avatar}, :creation]).order(created_at: :desc).limit(limit)
  end

  def comment_on(creation, text, disqus_id)
    creation.comments.create(text: text, user: self, disqus_id: disqus_id)
  end

  def favorite_cakes
    favorites.includes(creation: [:photos, :user]).map(&:creation)
  end

  def create_cake(name:, category:)
    creations.create(name: name, category_id: category.id)
  end

  def notify_of_activity
    NotificationMailer.notification_email(self).deliver_later
  end

  class << self
    def login(email, password)
      user = User.find_by(email: email)
      return false if user.nil?
      user.user_sessions.create! if user.authenticate(password)
    end
  end

  private

  def ensure_authentication_token
    self.authentication_token = SecureRandom.hex(32) if self.authentication_token.blank?
  end
end
