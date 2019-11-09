class AddIndexUnique < ActiveRecord::Migration[6.0]
  def change
    add_index :countries, [:provider_id,:sync_excel_id,:name], unique: true
    add_index :states, [:country_id,:provider_id,:sync_excel_id,:name], unique: true, name: 'states_country_name'
  end
end
