class CommentOnCreationCommand
  def initialize(user)
    @current_user = user
  end
  def run(params)
    comment = @current_user.comment_on(Creation.find(params[:creation_id]), params[:comment][:body])
    comment.save
  end
end
