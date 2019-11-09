class Precinct < ApplicationRecord
  belongs_to :location
  belongs_to :provider
  belongs_to :sync_excel

  has_many :voting_tables, dependent: :destroy

  validates :name, uniqueness: {
      scope: [:location_id,:provider_id,:sync_excel_id]
  }
end
