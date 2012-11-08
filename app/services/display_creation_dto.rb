class DisplayCreationDTO
  attr_accessor :id, :name, :story, :primary_image, :thumb_url, :user, :favorites, :comment_threads
  def self.model_name
    ActiveModel::Name.new(self, nil, 'Creation')
  end
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
