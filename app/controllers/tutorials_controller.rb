class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.search(params[:q]).page(page).per(per_page)
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end
end
