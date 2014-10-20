class CommandBus
  def initialize(queue = Delayed::Job)
    @queue = queue
  end

  def publish(event, payload)
    @queue.enqueue(QueuedJob.new(event, payload))
  end
end
