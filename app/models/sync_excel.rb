class SyncExcel < ApplicationRecord
  belongs_to :provider
  validates :folder_name, uniqueness: {
      scope: :provider_id
  }
end
