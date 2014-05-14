class RemoveCakeCommand
  def initialize(context, current_user = context.current_user)
    @context = context
    @current_user = current_user
  end

  def run(creation_id)
    @current_user.creations.find(creation_id).destroy
  end
end
