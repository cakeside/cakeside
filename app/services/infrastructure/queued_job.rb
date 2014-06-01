class QueuedJob < Struct.new(:event, :payload)
  def perform
    handlers_for(event).each { |handler| handler.handle(payload) }
  end

  def error(job, exception)
    ExceptionNotifier.notify_exception(exception) unless Rails.env.test?
  end

  private

  def handlers_for(event)
    container.resolve_all(:message_handler).find_all do |handler|
      handler.handles?(event)
    end
  end

  def container
    @container ||= Spank::IOC.resolve(:container)
  end
end

