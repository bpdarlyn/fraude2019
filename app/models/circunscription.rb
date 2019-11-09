class Circunscription < ApplicationRecord
  belongs_to :municipality
  belongs_to :provider
  belongs_to :sync_excel

  has_many :locations, dependent: :destroy

  validates :name, uniqueness: {
      scope: [:municipality_id,:provider_id, :sync_excel_id]
  }
end
