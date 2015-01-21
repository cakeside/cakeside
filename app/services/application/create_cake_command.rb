class CreateCakeCommand
  def initialize(context, current_user = context.current_user)
    @context = context
    @current_user = current_user
  end

  def run(attributes, tags)
    cake = @current_user.create_cake(name: attributes[:name], category: Category.find(attributes[:category_id]))
    @current_user.tag(cake, with: tags, on: :tags)

    if cake.save
      PublishToTwitterJob.set(wait_until: 1.hour.from_now).perform_later(cake)
      @context.create_cake_succeeded(cake)
    else
      @context.create_cake_failed(cake)
    end
  end
end
