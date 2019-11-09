class AddProviderToSyncExcel < ActiveRecord::Migration[6.0]
  def change
    add_reference :sync_excels, :provider, null: false, foreign_key: true
  end
end
