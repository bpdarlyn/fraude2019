class DenormalizeDatum < ApplicationRecord
  belongs_to :provider
  belongs_to :sync_excel
end
