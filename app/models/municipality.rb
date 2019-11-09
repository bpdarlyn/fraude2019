class Municipality < ApplicationRecord
  belongs_to :province
  belongs_to :provider
  belongs_to :sync_excel

  has_many :circunscriptions, dependent: :destroy

  validates :name, uniqueness: {
      scope: [:province_id,:provider_id,:sync_excel_id]
  }
end
