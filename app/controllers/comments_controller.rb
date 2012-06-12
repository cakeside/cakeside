class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    command_for(CommentOnCreationCommand).run(params)
    flash[:notice] = params[:comment][:body]
    redirect_to :controller => 'creations', :action => 'show', :id => params[:creation_id]
  end
end
