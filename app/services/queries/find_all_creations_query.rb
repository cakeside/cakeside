class FindAllCreationsQuery
  def initialize(repository = Creation.where(nil))
    @repository = repository
  end

  def fetch(params)
    find_creations.page(params[:page]).per(9)
  end

  private

  def find_creations
    @repository
    .includes(:user, :photos)
    .where(:is_restricted => false)
    .where('photos_count > 0')
    .uniq
  end
end
