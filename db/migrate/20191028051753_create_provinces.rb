class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.references :state, null: false, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
