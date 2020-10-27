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
    Provider.all.each do |provider|
      # each only computo TSE
      provider.sync_excels.each do |sync_excel|
        ImporterJob.perform_later(sync_excel, provider, type)
      end
    end
  end

end
