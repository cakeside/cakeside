class CommentsController < ApplicationController
  def create
    creation = Creation.find(creation_id)
    @comment = current_user.comment_on(creation, comment_params[:text], comment_params[:id])
    render json: @comment
  end

  private

  def creation_id
    params[:url].match(/\/(\d+)/)[0].gsub("/", "")
  end

  def comment_params
    params.require(:comment).permit(:id, :text)
  end
end
