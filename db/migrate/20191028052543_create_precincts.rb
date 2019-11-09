class CreatePrecincts < ActiveRecord::Migration[6.0]
  def change
    create_table :precincts do |t|
      t.references :location, null: false, foreign_key: true
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
