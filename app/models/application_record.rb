class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.import_with_transaction(raw_models)
    transaction do
      import(raw_models,
             validate: false,
             validate_uniqueness: false,
             on_duplicate_key_ignore: true,
             ignore:true
      )
    end
  end
end
