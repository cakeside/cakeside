class CreateCakeCommand
  def initialize(context, current_user = context.current_user, command_bus = Spank::IOC.resolve(:command_bus))
    @context = context
    @current_user = current_user
    @command_bus = command_bus
  end

  def run(attributes, tags)
    cake = @current_user.create_cake(name: attributes[:name], category: Category.find(attributes[:category_id]))
    @current_user.tag(cake, with: tags, on: :tags)

    if cake.save
      @command_bus.publish(:cake_published, cake_id: cake.id)
      @context.create_cake_succeeded(cake)
    else
      @context.create_cake_failed(cake)
    end
  end
end
