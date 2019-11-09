class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
