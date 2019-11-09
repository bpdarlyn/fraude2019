class CreateTypeOfElections < ActiveRecord::Migration[6.0]
  def change
    create_table :type_of_elections do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
