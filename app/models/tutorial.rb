class Tutorial < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  attr_accessible :description, :heading, :url, :image_url, :user_id, :author, :author_url
  validates :url,  :presence => true
  belongs_to :user
  acts_as_taggable

  default_scope order("created_at DESC")

  def to_param
    "#{id}-#{heading.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
