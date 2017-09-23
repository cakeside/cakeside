class Tool < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :asin, presence: true
end
