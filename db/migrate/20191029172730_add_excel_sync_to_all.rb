class AddExcelSyncToAll < ActiveRecord::Migration[6.0]
  def change
    add_reference :circunscriptions, :sync_excel, foreign_key: true
    add_reference :countries, :sync_excel, foreign_key: true
    add_reference :locations, :sync_excel, foreign_key: true
    add_reference :municipalities, :sync_excel, foreign_key: true
    add_reference :precincts, :sync_excel, foreign_key: true
    add_reference :states, :sync_excel, foreign_key: true
    add_reference :voting_tables, :sync_excel, foreign_key: true
    add_reference :votes, :sync_excel, foreign_key: true
    add_reference :provinces, :sync_excel, foreign_key: true
  end
end
