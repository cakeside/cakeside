class UpdateCakeCommand
  def initialize(context)
    @context = context
  end

  def run(id, category_id, creation_tags, creation_params)
    current_user = @context.current_user

    creation = current_user.creations.find(id)
    creation.categories.clear
    creation.categories << Category.find(category_id) if category_id
    current_user.tag(creation, with: creation_tags, on: :tags)

    if creation.update_attributes(creation_params)
      @context.update_cake_succeeded(creation)
    else
      @context.update_cake_failed(creation)
    end
  end
end
