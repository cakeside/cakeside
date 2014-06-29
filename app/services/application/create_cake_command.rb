class CreateCakeCommand
  def initialize(context, current_user = context.current_user, message_bus = Spank::IOC.resolve(:message_bus))
    @context = context
    @current_user = current_user
    @message_bus = message_bus
  end

  def run(attributes, tags)
    cake = @current_user.create_cake(name: attributes[:name], description: attributes[:story], category: Category.find(attributes[:category_id]), watermark: attributes[:watermark])
    cake.hide_from_children! if attributes[:is_restricted].present? && attributes[:is_restricted] == true
    @current_user.tag(cake, with: tags, on: :tags)

    if cake.save
      @message_bus.publish(:cake_published, cake_id: cake.id)
      @context.create_cake_succeeded(cake)
    else
      @context.create_cake_failed(cake)
    end
  end
end
