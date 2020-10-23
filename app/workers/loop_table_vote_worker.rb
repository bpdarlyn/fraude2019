class LoopTableVoteWorker
  include Sidekiq::Worker
  # will be completely ephemeral, not in Retry or Dead
  sidekiq_options retry: false

  def perform(block_denormalize_data_ids)
    # do something
    block_denormalize_data = DenormalizeDatum.where(id: block_denormalize_data_ids)
    block_denormalize_data.each do |dd|
      ct = CompareTable.new(dd.table_code)
      sleep(500)
      ct.do_request
    end
    p "COMPLETE EACH BLOCK DENORMALIZE DATA"
  end
end