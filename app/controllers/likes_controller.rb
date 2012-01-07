class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_creation

  # GET /likes
  def index
    @likes = @creation.likes
  end

  # POST /likes
  def create
    @like = @creation.likes.create(params[:like])
    @like.user_id = current_user.id

    if @like.save
       redirect_to @creation, :notice => 'Like was successfully created.'
    else
       redirect_to @creation
    end
  end

  private
  def find_creation
    @creation = current_user.creations.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end
end
