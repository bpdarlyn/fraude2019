class Country < ApplicationRecord
  belongs_to :provider
  belongs_to :sync_excel

  has_many :states, dependent: :destroy

  # validates :name, uniqueness: {
  #     scope: [:provider_id, :sync_excel_id]
  # }

end
