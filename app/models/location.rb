class Location < ApplicationRecord
  belongs_to :circunscription, optional: true
  belongs_to :provider
  belongs_to :sync_excel
  has_many :precincts, dependent: :destroy
  validates :name, uniqueness: {
      scope: [:circunscription_id,:provider_id,:sync_excel_id]
  }
end
