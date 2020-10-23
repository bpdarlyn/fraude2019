class TableVote < ApplicationRecord
  belongs_to :denormalize_data, class_name: 'DenormalizeDatum'
  belongs_to :sync_excel
end
