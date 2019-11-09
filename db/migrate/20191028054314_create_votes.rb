class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :voting_table, null: false, foreign_key: true
      t.references :politic_party, null: false, foreign_key: true
      t.references :type_of_election, null: false, foreign_key: true
      t.integer :total_votes

      t.timestamps
    end
  end
end
