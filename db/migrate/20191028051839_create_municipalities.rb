class CreateMunicipalities < ActiveRecord::Migration[6.0]
  def change
    create_table :municipalities do |t|
      t.references :province, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
