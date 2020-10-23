class CompareTable
  attr_accessor :table_code, :denormalize_data

  def initialize(table_code, denormalize_data)
    @table_code = table_code
    @denormalize_data = denormalize_data
  end

  def self.run
    dds = SyncExcel.last.denormalize_data
    count_dds = dds.count
    divisor = 15
    step = count_dds / divisor
    i = 0
    while i < divisor
      block_dd = dds.limit(step).offset(i * step)
      LoopTableVoteWorker.perform_async(block_dd.ids)
      i += 1
    end
  end

  def url_trep
    "https://computo.oep.org.bo/api/v1/resultado/mesa"
  end

  def columns
    {
        c: 0,
        adn: 1,
        mas_ipsp: 2,
        fpv: 3,
        pan_bol: 4,
        libre_21: 5,
        cc: 6,
        juntos: 7,
        valid_votes: 9,
        blank_votes: 10,
        null_votes: 11,
        emit_votes: 12
    }
  end

  def process_response(response_hash)
    c = response_hash['datoAdicional']['tabla'][columns[:c]]
    adn = response_hash['datoAdicional']['tabla'][columns[:adn]]
    mas_ipsp = response_hash['datoAdicional']['tabla'][columns[:mas_ipsp]]
    fpv = response_hash['datoAdicional']['tabla'][columns[:fpv]]
    pan_bol = response_hash['datoAdicional']['tabla'][columns[:pan_bol]]
    libre_21 = response_hash['datoAdicional']['tabla'][columns[:libre_21]]
    cc = response_hash['datoAdicional']['tabla'][columns[:cc]]
    juntos = response_hash['datoAdicional']['tabla'][columns[:juntos]]
    cpem_b = response_hash['datoAdicional']['tabla'][8]
    if cpem_b['nombre'] === 'CPEM-B'
      valid_votes = response_hash['datoAdicional']['tabla'][columns[:valid_votes]]
      blank_votes = response_hash['datoAdicional']['tabla'][columns[:blank_votes]]
      null_votes = response_hash['datoAdicional']['tabla'][columns[:null_votes]]
      emit_votes = response_hash['datoAdicional']['tabla'][columns[:emit_votes]]
    else
      valid_votes = response_hash['datoAdicional']['tabla'][columns[:valid_votes] - 1]
      blank_votes = response_hash['datoAdicional']['tabla'][columns[:blank_votes] - 1]
      null_votes = response_hash['datoAdicional']['tabla'][columns[:null_votes] - 1]
      emit_votes = response_hash['datoAdicional']['tabla'][columns[:emit_votes] - 1]
    end

    new_attributes = {
        c: c['valor1'],
        adn: adn['valor1'],
        mas_ipsp: mas_ipsp['valor1'],
        fpv: fpv['valor1'],
        pan_bol: pan_bol['valor1'],
        libre_21: libre_21['valor1'],
        cc: cc['valor1'],
        juntos: juntos['valor1'],
        valid_votes: valid_votes['valor1'],
        blank_votes: blank_votes['valor1'],
        null_votes: null_votes['valor1'],
        emit_votes: emit_votes['valor1'],
        denormalize_data: denormalize_data,
        sync_excel_id: denormalize_data.sync_excel_id,
        obs: response_hash['datoAdicional']['observacion']
    }
    if response_hash['datoAdicional']['adjunto'] && response_hash['datoAdicional']['adjunto'][0] &&
        response_hash['datoAdicional']['adjunto'][0]['tipo'] === 'ACTA'
      new_attributes[:attachment_url] = response_hash['datoAdicional']['adjunto'][0]['valor']
    end
    TableVote.create!(new_attributes)
  end

  def do_request
    begin
      response = RestClient.post(url_trep, {codigoMesa: table_code}.to_json, headers = {content_type: :json})
      hash_body = JSON.parse(response.body)
      process_response(hash_body)
      true
    rescue StandardError => e
      puts "Rescued: #{e.message}"
      false
    end
  end
end