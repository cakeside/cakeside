class CreationToDisplayCreationDTOMapper
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
