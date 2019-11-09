class Vote < ApplicationRecord
  belongs_to :voting_table
  belongs_to :politic_party
  belongs_to :type_of_election
  belongs_to :provider
  belongs_to :sync_excel
end
