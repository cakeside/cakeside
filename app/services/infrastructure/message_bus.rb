class MessageBus
  def initialize(container)
    @container = container
  end

  def publish(event, payload)
    handlers_for(event).each { |handler| handler.handle(payload) }
  end

  private

  def handlers_for(event)
    @container.resolve_all(:message_handler).find_all do |handler|
      handler.handles?(event)
    end
  end
end
