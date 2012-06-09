class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    creation = Creation.find(params[:creation_id])
    comment = Comment.build_from(creation, current_user.id, params[:comment][:body])
    if comment.save
      flash[:notice] = "Your comment was added!"
      redirect_to creation_path(creation)
    else
      flash[:error] = "Ooops... we couldn't save your comment at this time."
      #render 'creations/new'
    end
  end
end
