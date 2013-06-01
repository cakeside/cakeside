class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    comment = resolve(CommentOnCreationCommand).run(params)
    redirect_to comment.commentable, :notice => 'Nice Comment!'
  end
end
