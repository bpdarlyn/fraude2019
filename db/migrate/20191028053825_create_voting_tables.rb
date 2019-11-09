class CreateVotingTables < ActiveRecord::Migration[6.0]
  def change
    create_table :voting_tables do |t|
      t.references :precinct, null: false, foreign_key: true
      t.string :table_number
      t.string :table_code
      t.integer :total_enrollments
      t.integer :valid_votes
      t.integer :blank_votes
      t.integer :null_votes
      t.string :act_state
      t.datetime :catch_date
      t.references :provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
