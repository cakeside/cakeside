class UploadImageWorker < ::CarrierWave::Workers::StoreAsset
  def error(job, exception)
    ExceptionNotifier.notify_exception(exception, :data => {:worker => worker.to_s, :queue => queue, :payload => payload})
  end
end
