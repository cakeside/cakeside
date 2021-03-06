module Pageable
  extend ActiveSupport::Concern
  DEFAULT_PER_PAGE=12

  def page
    params[:page]
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def paginate(items)
    items.page(page).per(per_page)
  end
end
