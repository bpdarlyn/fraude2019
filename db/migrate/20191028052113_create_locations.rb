class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.references :circunscription, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
