class Tutorial < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :user
  acts_as_taggable
  default_scope -> { order('tutorials.created_at desc') }

  def to_param
    "#{id}-#{heading.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
