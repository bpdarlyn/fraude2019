class LoopTableVoteWorker
  include Sidekiq::Worker
  # will be completely ephemeral, not in Retry or Dead
  sidekiq_options retry: false

  def perform(block_denormalize_data_ids)
    # do something
    block_denormalize_data = DenormalizeDatum.where(id: block_denormalize_data_ids)
    block_denormalize_data.each do |dd|
      ct = CompareTable.new(dd.table_code, dd)
      sleep(5)
      sync = ct.do_request
      dd.update(sync: sync)
    end
    p "COMPLETE EACH BLOCK DENORMALIZE DATA"
  end
end