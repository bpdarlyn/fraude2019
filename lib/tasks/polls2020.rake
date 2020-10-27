namespace :polls2020 do
  desc "TODO"

  task sync_excels: :environment do
    vote_importer = VoteImporter.new
    vote_importer.sync_excels_with_provider
    vote_importer.import_all 'denormalize'
  end

  task sync_tables: :environment do
    CompareTable.run
  end

end
