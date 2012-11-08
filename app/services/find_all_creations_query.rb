class FindAllCreationsQuery
  def initialize(user, mapper = CreationToDisplayCreationDTO.new)
    @user = user
    @mapper = mapper
  end
  def fetch(params)
    make_pageable(find_creations.map {|c| @mapper.map_from(c) }, params[:page])
  end

  private

  def find_creations
    Creation.all.select do |creation|
      creation.published? && creation.is_safe_for_children?
    end
  end
  def make_pageable(items, page)
    Kaminari.paginate_array(items).page(page).per(16)
  end
end
class CreationToDisplayCreationDTO
  def map_from(creation)
    dto = DisplayCreationDTO.new
    dto.id = creation.id
    dto.name = creation.name
    dto.story = creation.story
    dto.primary_image = creation.primary_image
    dto.thumb_url = creation.primary_image.image.thumb.url
    dto.user = creation.user
    dto.favorites = creation.favorites
    dto.comment_threads = creation.comment_threads
    dto
  end
end
class DisplayCreationDTO
  attr_accessor :id, :name, :story, :primary_image, :thumb_url, :user, :favorites, :comment_threads
  def self.model_name
    ActiveModel::Name.new(self, nil, 'Creation')
  end
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
