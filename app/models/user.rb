class User < ActiveRecord::Base
  validates :name,  :presence => true
  has_many :authentications
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :creations, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  def like( creation )
    if self.already_likes(creation)
      logger.info 'already likes creation'
      likes.find { |like| like.user == self }
    else
      logger.info 'add creation'
      creation.likes.create({:user => self})
    end
  end

  def already_likes(creation)
    Like.where("user_id = ? AND creation_id = ?", self.id, creation.id).exists?
    # likes.any? do |like|
    #   like.user == self && like.creation == creation
    # end
  end
end
