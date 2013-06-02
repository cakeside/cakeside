class FindAllCreationsQuery
  def initialize(mapper = CreationToDisplayCreationDTOMapper.new)
    @mapper = mapper
  end

  def fetch(params)
    find_creations.page(params[:page]).per(9)
  end

  private

  def find_creations
    Creation.includes(:user, :photos).where(:is_restricted => false).uniq
  end
end
