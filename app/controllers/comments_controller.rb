class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  #def create
    #creation = Creation.find(params[:creation_id])
    #comment = Comment.build_from(creation, current_user.id, params[:comment][:body])
    #comment.save
    #flash[:notice] = params[:comment][:body]
    #redirect_to :controller => 'creations', :action => 'show', :id => params[:creation_id]
  #end
  def create
    CommentOnCreationCommand.new(current_user).run(params)

    flash[:notice] = params[:comment][:body]
    redirect_to :controller => 'creations', :action => 'show', :id => params[:creation_id]
  end
end
