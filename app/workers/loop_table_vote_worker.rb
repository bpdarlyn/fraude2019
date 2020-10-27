class LoopTableVoteWorker
  include Sidekiq::Worker
  # will be completely ephemeral, not in Retry or Dead
  sidekiq_options retry: false

  def perform(block_denormalize_data_ids)
    # do something
    block_denormalize_data = DenormalizeDatum.where(id: block_denormalize_data_ids)
    table_votes = []
    block_denormalize_data.each do |dd|
      ct = CompareTable.new(dd.table_code, dd)
      sleep(10)
      table_vote_model = ct.do_request
      if table_vote_model
        table_votes << table_vote_model
      end
    end
    TableVote.import_with_transaction(table_votes)
    p "COMPLETE EACH BLOCK DENORMALIZE DATA"
  end
end