class CreateDenormalizeData < ActiveRecord::Migration[6.0]
  def change
    create_table :denormalize_data do |t|
      t.integer :table_code
      t.string :type_of_vote
      t.string :country
      t.string :state
      t.integer :circumscription
      t.string :province
      t.string :municipality
      t.string :location
      t.string :precinct
      t.integer :table_number
      t.integer :total_enrollments
      t.integer :c
      t.integer :adn
      t.integer :mas_ipsp
      t.integer :fpv
      t.integer :pan_bol
      t.integer :libre_21
      t.integer :cc
      t.integer :juntos
      t.integer :valid_votes
      t.integer :blank_votes
      t.integer :null_votes
      t.integer :emit_vote
      t.integer :valid_system_vote
      t.integer :emit_system_vote
      t.boolean :sync, default: false
      t.references :provider, null: false, foreign_key: true
      t.references :sync_excel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
