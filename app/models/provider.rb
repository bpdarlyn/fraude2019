class Provider < ApplicationRecord

  has_many :sync_excels, dependent: :destroy

  def path_file
    if self.code.to_i === 1
      "#{root_folder}/#{ENV['TREP_FOLDER']}"
    else
      "#{root_folder}/#{ENV['COMPUTO_FOLDER']}"
    end
  end

  def root_folder
    ENV['ROOT_FOLDER_EXCEL']
  end
end
