class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.includes(:tags).page(params[:page]).per(15)
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end
end
