class LoopExcel


  def loop_rows(provider, sync_excel, type)
    full_path = "#{provider.path_file}/#{sync_excel.folder_name}"
    @file = Creek::Book.new((File.realpath(full_path)))
    data_model = []
    columns = {
        table_code: 'A',
        type_of_vote: 'B',
        country: 'D',
        state: 'F',
        circumscription: 'G',
        province: 'I',
        municipality: 'K',
        location: 'M',
        precinct: 'O',
        table_number: 'P',
        total_enrollments: 'Q',
        c: 'R',
        adn: 'S',
        mas_ipsp: 'T',
        fpv: 'U',
        pan_bol: 'V',
        libre_21: 'W',
        cc: 'X',
        juntos: 'Y',
        valid_votes: 'Z',
        blank_votes: 'AA',
        null_votes: 'AB',
        emit_vote: 'AC',
        valid_system_vote: 'AD',
        emit_system_vote: 'AE',
    }
    sheet.simple_rows.each do |hash_row|
      next if hash_row[columns[:country]] === 'PAIS' # check if is the first row to skip the header
      row_excel = RowExcel.new(hash_row,provider,sync_excel, columns, type)
      data_model << row_excel.build_row
    end
    data_model
  end

  def sheet
    @file.sheets[0]
  end

end