class User < ActiveRecord::Base
  validates :name,  :presence => true
  has_many :authentications
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  def add_favorite( creation )
    if self.already_likes(creation)
      logger.info 'already likes creation'
      favorites.find { |favorite| favorite.user == self }
    else
      logger.info 'add creation'
      creation.favorites.create({:user => self})
    end
  end

  def already_likes(creation)
    Favorite.where("user_id = ? AND creation_id = ?", self.id, creation.id).exists?
  end
end
