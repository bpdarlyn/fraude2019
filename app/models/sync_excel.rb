class SyncExcel < ApplicationRecord
  belongs_to :provider

  has_many :denormalize_data, class_name: 'DenormalizeDatum'

  validates :folder_name, uniqueness: {
      scope: :provider_id
  }
end
