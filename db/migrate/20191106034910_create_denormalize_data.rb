class CreateDenormalizeData < ActiveRecord::Migration[6.0]
  def change
    create_table :denormalize_data do |t|
      t.string :country
      t.integer :state_code
      t.string :state
      t.string :province
      t.integer :municipality_code
      t.string :municipality
      t.string :circumscription
      t.string :location
      t.string :precinct
      t.integer :polling_station_number
      t.string :polling_station_code
      t.string :type_of_vote
      t.integer :total_enrollments
      t.integer :cc
      t.integer :fpv
      t.integer :mts
      t.integer :ucs
      t.integer :mas_ipsp
      t.integer :twenty_one_f
      t.integer :pdc
      t.integer :mnr
      t.integer :pan_bol
      t.integer :valid_votes
      t.integer :blank_votes
      t.integer :null_votes
      t.string :act_state
      t.references :provider, null: false, foreign_key: true
      t.references :sync_excel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
