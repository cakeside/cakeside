class MigratePrimaryImage < Struct.new(:creation_id)
  def perform
    creation = Creation.find(creation_id)
    photo = creation.photos.build({})
    photo.created_at = creation.created_at
    photo.updated_at = creation.updated_at
    photo.image = creation.image.file
    photo.save!
  end
end
