module My
  class BaseController < ApplicationController
    before_filter :authenticate!
  end
end
