class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_creation

  # GET /likes
  def index
    @likes = @creation.likes
  end

  # POST /likes
  def create
    if( current_user == @creation.user )
      redirect_to @creation, :notice => "You can't like your own stuff"
      return
    end
    @like = current_user.like(@creation)
    if @like.save
       redirect_to @creation, :notice => 'Welcome to the fanclub!'
    else
       redirect_to @creation
    end
  end

  private
  def find_creation
    @creation = Creation.find(params[:creation_id])
    raise ActiveRecord::RecordNotFound unless @creation
  end
end
