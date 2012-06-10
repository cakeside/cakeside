class CommentOnCreationCommand
  def initialize(user)
    @current_user = user
  end
  def run(params)
    creation = Creation.find(params[:creation_id])
    comment = Comment.build_from(creation, @current_user.id, params[:comment][:body])
    comment.save
  end
end
