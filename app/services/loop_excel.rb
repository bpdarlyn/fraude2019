class LoopExcel


  def loop_rows(provider, sync_excel, type)
    full_path = "#{provider.path_file}/#{sync_excel.folder_name}"
    @file = Creek::Book.new((File.realpath(full_path)))
    data_model = []
    columns = {country: 'A', state_code: 'B', state: 'C',
               province: 'D', municipality_code: 'E', municipality: 'F',
               circumscription: 'G', location: 'H', precinct: 'I',
               polling_station_number: 'J', polling_station_code: 'K', type_of_vote: 'L',
               total_enrollments: 'M',
               cc: 'N',
               fpv: 'O',
               mts: 'P',
               ucs: 'Q',
               mas_ipsp: 'R',
               twenty_one_f: 'S',
               pdc: 'T',
               mnr: 'U',
               pan_bol: 'V',
               valid_votes: 'W',
               blank_votes: 'X',
               null_votes: 'Y',
               act_state: 'Z'
    }
    if provider.code === 1 # is trep ?
      columns.delete :act_state
    end
    sheet.simple_rows.each do |hash_row|
      next if hash_row[columns[:country]] === 'País' # check if is the first row to skip the header
      row_excel = RowExcel.new(hash_row,provider,sync_excel, columns, type)
      data_model << row_excel.build_row
    end
    data_model
  end

  def sheet
    @file.sheets[0]
  end

end