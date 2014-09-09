class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.includes(:user).page(params[:page]).per(12)
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end
end
