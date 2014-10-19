module Queryable
  extend ActiveSupport::Concern

  module ClassMethods
    def all_matching(search_filters)
      search_filters.inject(self) do |memo, next_filter|
        next_filter.call(memo)
      end
    end
  end
end
