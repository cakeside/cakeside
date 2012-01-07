class User < ActiveRecord::Base
  validates :name,  :presence => true
  has_many :authentications
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :creations, :dependent => :destroy
  has_many :likes, :dependent => :destroy
end
