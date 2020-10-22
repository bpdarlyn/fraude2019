class VoteImporter

  attr_accessor :root_folder, :trep_folder, :computo_folder

  attr_accessor :file


  def sync_excels_with_provider
    Provider.all.each do |provider|
      excels = []
      Dir["#{provider.path_file}/*"].each do |file|
        base_name = File.basename(file)
        split_name_file = base_name.split('_')
        split_name_file = split_name_file.compact
        section_date = split_name_file[2]
        year = section_date[0..3]
        month = section_date[4..2]
        day = section_date[7..2]
        section_time = split_name_file[3]
        hour = section_time[0..2]
        minute = section_time[2..2]
        secs = section_time[4..2]
        catch_date = "#{year}-#{month}-#{day} #{hour}:#{minute}:#{secs}"
        excels << {folder_name: base_name, provider: provider, sync_at: catch_date}
      end
      SyncExcel.create(excels)
    end
  end


  def import_all(type)
    Provider.all.where(code: 1).each do |provider| # each only computo TSE
      provider.sync_excels.order(sync_at: :desc).each do |sync_excel|
        ImporterJob.perform_later(sync_excel, provider, type)
      end
    end
  end


  def fill_votes(row)


    ["CC", "FPV", "MTS", "UCS", "MAS - IPSP",
     "21F", "PDC", "MNR", "PAN-BOL"].each do |index_politic_party|
      politic_party = PoliticParty.find_or_create_by(name: index_politic_party, code: index_politic_party)
      index_total_votes = case index_politic_party
                          when 'CC'
                            13
                          when 'FPV'
                            14
                          when 'MTS'
                            15
                          when 'UCS'
                            16
                          when 'MAS - IPSP'
                            17
                          when '21F'
                            18
                          when 'PDC'
                            19
                          when 'MNR'
                            20
                          when 'PAN-BOL'
                            21
                          else
                            -1
                          end
      if index_total_votes > -1
        @type_of_election = TypeOfElection.find_or_create_by(name: row[11])
        Vote.find_or_create_by(voting_table: @voting_table,
                               politic_party: politic_party,
                               type_of_election: @type_of_election,
                               total_votes: row[index_total_votes])

      end
    end

  end

end
