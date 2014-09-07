module My
  class BaseController < ApplicationController
    before_action :authenticate!
  end
end
