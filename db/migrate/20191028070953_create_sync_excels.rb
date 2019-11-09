class CreateSyncExcels < ActiveRecord::Migration[6.0]
  def change
    create_table :sync_excels do |t|
      t.string :folder_name
      t.datetime :sync_at

      t.timestamps
    end
  end
end
