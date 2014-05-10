class UploadImageWorker < ::CarrierWave::Workers::StoreAsset
  def error(job, exception)
    ExceptionNotifier.notify_exception(exception)
  end
end
