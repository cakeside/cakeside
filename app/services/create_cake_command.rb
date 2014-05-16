class CreateCakeCommand
  def initialize(context, current_user = context.current_user, publisher = TwitterPublisher.new)
    @context = context
    @current_user = current_user
  end

  def run(creation_attributes, category_id, tags)
    cake = @current_user.creations.create(creation_attributes)
    cake.categories << Category.find(category_id) if category_id
    @current_user.tag(cake, with: tags, on: :tags)

    if cake.save
      publisher.publish(cake)
      @context.create_cake_succeeded(cake)
    else
      @context.create_cake_failed(cake)
    end
  end
end
