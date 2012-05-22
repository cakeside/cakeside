class UrlValidation < ActiveModel::Validator
  def validate(record)
    if(record.website.starts_with? 'http://')

    else
      record.errors[:website] << 'is invalid'
    end
  end
end

class User < ActiveRecord::Base
  validates :name,  :presence => true
  validates :website, :format => URI::regexp(%w(http https)), :allow_blank => true
  #validates_with UrlValidation
  has_many :authentications
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :website, :twitter, :facebook, :password, :password_confirmation, :remember_me
  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  def add_favorite( creation )
    if self.already_likes(creation)
      logger.info 'already likes creation'
      favorites.find { |favorite| favorite.user == self }
    else
      logger.info 'add creation'
      creation.favorites.create({:user_id => self.id})
    end
  end

  def already_likes(creation)
    Favorite.where("user_id = ? AND creation_id = ?", self.id, creation.id).exists?
  end

  def owns(creation)
    creation.user == self
  end
end

