class CreatePoliticParties < ActiveRecord::Migration[6.0]
  def change
    create_table :politic_parties do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
