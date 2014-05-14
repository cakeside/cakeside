class CreateCakeCommand
  def initialize(context, current_user = context.current_user)
    @context = context
    @current_user = current_user
  end

  def run(creation_attributes, category_id, tags)
    creation = @current_user.creations.create(creation_attributes)
    creation.categories << Category.find(category_id) if category_id
    @current_user.tag(creation, with: tags, on: :tags)

    if creation.save
      @context.create_cake_succeeded(creation)
    else
      @context.create_cake_failed(creation)
    end
  end
end
