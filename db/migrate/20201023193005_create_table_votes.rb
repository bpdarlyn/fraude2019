class CreateTableVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :table_votes do |t|
      t.references :denormalize_data, null: false, foreign_key: true
      t.references :sync_excel, null: false, foreign_key: true
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
      t.integer :emit_votes
      t.string :obs
      t.string :attachment_url
      t.integer :table_code

      t.timestamps
    end
    add_index :table_votes, [:denormalize_data_id, :sync_excel_id], unique: true
  end
end
