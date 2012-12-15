class FindAllCreationsQuery
  def initialize(user, mapper = CreationToDisplayCreationDTOMapper.new)
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