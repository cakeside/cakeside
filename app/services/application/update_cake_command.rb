class UpdateCakeCommand
  def initialize(context)
    @context = context
  end

  def run(id, tags, creation_params)
    current_user = @context.current_user

    cake = current_user.creations.find(id)
    current_user.tag(cake, with: tags, on: :tags)

    if cake.update_attributes(creation_params)
      @context.update_cake_succeeded(cake)
    else
      @context.update_cake_failed(cake)
    end
  end
end
