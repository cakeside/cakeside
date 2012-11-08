class CommentOnCreationCommand
  def initialize(user)
    @current_user = user
  end
  def run(message)
    comment = @current_user.comment_on(Creation.find(message[:creation_id]), message[:comment][:body])
    comment.save
    comment
  end
end
