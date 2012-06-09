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
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :password, :password_confirmation, :current_password
  attr_accessible :name, :email, :website, :twitter, :facebook, :city, :latitude, :longitude, :password, :password_confirmation, :current_password, :remember_me, :interest_ids
  has_many :creations, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :authentications
  has_and_belongs_to_many :interests, :join_table => 'users_interests', :uniq => true, :autosave => true

  def add_favorite( creation )
    if self.already_likes(creation)
      favorites.find { |favorite| favorite.user == self }
    else
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

