class State < ApplicationRecord
  belongs_to :country
  belongs_to :provider
  belongs_to :sync_excel

  has_many :provinces, dependent: :destroy

  # validates :name, uniqueness: {
  #     scope: [:country_id,:provider_id,:sync_excel_id]
  # }
end
