class ImporterJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(sync_excel,provider, type)
    loop_excel = LoopExcel.new
    larger_data = loop_excel.loop_rows(provider, sync_excel,type)
    ImporterLogger.info 'Creating Data'
    ImporterLogger.info larger_data.size
    import(type, larger_data)
    ImporterLogger.info 'Created Data'
  end

  def import(type, raw_data)
    case type
    when 'country'
      Country.import_with_transaction(raw_data)
    when 'state'
      State.import_with_transaction(raw_data)
    when 'province'
      Province.import_with_transaction(raw_data)
    when 'denormalize'
      DenormalizeDatum.import_with_transaction(raw_data)
    else
      nil
    end
  end


end
