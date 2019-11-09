class CreateCircunscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :circunscriptions do |t|
      t.references :municipality, null: false, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
