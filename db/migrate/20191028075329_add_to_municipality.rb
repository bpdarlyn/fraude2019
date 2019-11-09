class AddToMunicipality < ActiveRecord::Migration[6.0]
  def change
    add_column :municipalities, :name, :string
  end
end
