class CreateCakeCommand
  def initialize(context, current_user = context.current_user, message_bus = Spank::IOC.resolve(:message_bus))
    @context = context
    @current_user = current_user
    @message_bus = message_bus
  end

  def run(creation_attributes, tags)
    cake = @current_user.creations.create(creation_attributes)
    @current_user.tag(cake, with: tags, on: :tags)

    if cake.save
      @message_bus.publish(:new_creation_added, creation_id: cake.id)
      @context.create_cake_succeeded(cake)
    else
      @context.create_cake_failed(cake)
    end
  end
end
