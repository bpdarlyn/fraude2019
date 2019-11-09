class VotingTable < ApplicationRecord
  belongs_to :precinct
  belongs_to :provider
  belongs_to :sync_excel
  has_many :votes, dependent: :destroy
  validates :table_number, uniqueness: {
      scope: [:precinct,:provider_id,:sync_excel_id,:table_code]
  }
end
