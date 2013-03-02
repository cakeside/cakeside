class FindAllCreationsQuery
  def initialize(mapper = CreationToDisplayCreationDTOMapper.new)
    @mapper = mapper
  end
  def fetch(params)
    find_creations.page(params[:page]).per(9)
    #make_pageable(find_creations, params[:page])
    #make_pageable(find_creations.map {|c| @mapper.map_from(c) }, params[:page])
  end

  private

  def find_creations
    Creation.joins(:photos).where(:is_restricted => false).uniq
  end
  def make_pageable(items, page)
    Kaminari.paginate_array(items).page(page).per(9)
  end
end
