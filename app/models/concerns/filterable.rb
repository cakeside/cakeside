module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filtered_by(search_filters)
      search_filters.inject(self) do |memo, next_filter|
        next_filter.call(memo)
      end
    end
  end
end
