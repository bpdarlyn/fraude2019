class AddProviderReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :circunscriptions, :provider, foreign_key: true
    add_reference :countries, :provider, foreign_key: true
    add_reference :provinces, :provider, foreign_key: true
    add_reference :locations, :provider, foreign_key: true
    add_reference :municipalities, :provider, foreign_key: true
    add_reference :precincts, :provider, foreign_key: true
    add_reference :states, :provider, foreign_key: true
    add_reference :votes, :provider, foreign_key: true
  end
end
