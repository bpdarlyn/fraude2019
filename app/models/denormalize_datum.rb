class DenormalizeDatum < ApplicationRecord
  belongs_to :provider
  belongs_to :sync_excel
  has_one :table_vote, foreign_key: 'denormalize_data_id', dependent: :destroy
end
