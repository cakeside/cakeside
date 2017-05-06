module Queryable
  extend ActiveSupport::Concern

  included { send :include, ClassMethods }

  module ClassMethods
    def filter_by(filters)
      return all if filters.empty?
      filters.reduce(self) do |current_scope, filter|
        filter.call(current_scope)
      end
    end

    def query_builder_for(params)
      Queryable::Builder.new(params).tap do |builder|
        yield builder if block_given?
      end
    end
  end

  class Builder
    include Enumerable
    attr_reader :params, :filters
    delegate :empty?, to: :filters

    def initialize(params)
      @params = params
      @filters = []
    end

    def always(&filter)
      add do |relation|
        filter.call(relation)
      end
    end

    def if_present(key, &filter)
      return if params[key].nil? || params[key] == ''
      add do |relation|
        filter.call(relation, normalize(params[key]))
      end
    end

    def each(&block)
      @filters.each(&block)
    end

    private

    def add(&filter)
      @filters.push(filter)
    end

    def boolean?(value)
      true?(value) || false?(value)
    end

    def true?(value)
      "true" == value.to_s.downcase
    end

    def false?(value)
      "false" == value.to_s.downcase
    end

    def normalize(value)
      boolean?(value) ? true?(value) : value
    end
  end
end
