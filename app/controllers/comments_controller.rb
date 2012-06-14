class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    command_for(CommentOnCreationCommand).run(params)
    flash[:notice] = "Nice Comment!"
    redirect_to :controller => 'creations', :action => 'show', :id => params[:creation_id]
  end
end
