class Tool < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :asin, presence: true
end