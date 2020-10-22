namespace :polls2020 do
  desc "TODO"

  task import_denormalize_data: :environment do
    vote_importer = VoteImporter.new
    vote_importer.import_all 'denormalize'
  end

  task import_countries: :environment do
    vote_importer = VoteImporter.new
    vote_importer.import_all 'country'
  end

  task import_states: :environment do
    vote_importer = VoteImporter.new
    vote_importer.import_all 'state'
  end

  task import_provinces: :environment do
    vote_importer = VoteImporter.new
    vote_importer.import_all 'province'
  end

  task sync_excels: :environment do
    vote_importer = VoteImporter.new
    vote_importer.sync_excels_with_provider
  end

end
