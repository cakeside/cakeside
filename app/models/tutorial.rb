class Tutorial < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :user
  acts_as_taggable
  default_scope -> { order('tutorials.created_at desc') }
  scope :search, ->(query) do 
    query.blank? ? all : where(["UPPER(heading) LIKE :query OR UPPER(description) LIKE :query", { query: "%#{query.upcase}%" }]) 
  end

  def to_param
    "#{id}-#{heading.parameterize}"
  end
end
