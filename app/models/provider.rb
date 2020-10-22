class Provider < ApplicationRecord

  has_many :sync_excels, dependent: :destroy

  def path_file
    "#{root_folder}/#{ENV['TSE_FOLDER']}"
  end

  def root_folder
    ENV['ROOT_FOLDER_EXCEL']
  end
end
