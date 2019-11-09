class Province < ApplicationRecord
  belongs_to :state
  belongs_to :provider
  belongs_to :sync_excel

  has_many :municipalities, dependent: :destroy

  validates :name, uniqueness: {
      scope: [:state_id,:provider_id,:sync_excel_id]
  }
end
