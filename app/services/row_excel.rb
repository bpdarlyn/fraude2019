class RowExcel

  attr_writer :current_row, :provider, :sync_excel, :columns, :type
  attr_reader :current_row, :provider, :sync_excel, :columns, :type

  def initialize(current_row, provider, sync_excel, columns, type)
    self.current_row = current_row
    self.provider = provider
    self.sync_excel = sync_excel
    self.columns = columns
    self.type = type
  end

  def build_row
    case self.type
    when 'country'
      build_country
    when 'state'
      build_state
    when 'province'
      build_province
    when 'denormalize'
      build_denormalize
    else
      nil
    end
  end

  def build_denormalize
    new_attributes = columns.map { |k,v| [k, current_row[v]] }.to_h
    new_attributes = new_attributes.merge(provider_id: provider.id, sync_excel_id: sync_excel.id)
    new_attributes[:polling_station_code] = new_attributes[:polling_station_code].to_i
    DenormalizeDatum.new new_attributes
  end

  def build_country
    provider_id = provider.id
    sync_excel_id = sync_excel.id
    Country.new(name: current_row[columns[:country]],
                provider_id: provider_id,
                sync_excel_id: sync_excel_id)
  end

  def build_state
    country = Country.find_by(provider: provider, sync_excel: sync_excel, name: current_row[columns[:country]])
    provider_id = provider.id
    sync_excel_id = sync_excel.id
    country_id = country.id
    State.new(
        name: current_row[columns[:state]],
        code: current_row[columns[:state_code]].to_i,
        provider_id: provider_id,
        sync_excel_id: sync_excel_id,
        country_id: country_id
    )
  end

  def build_province
    state = State.find_by(provider: provider, sync_excel: sync_excel, name: current_row[columns[:state]])
    unless state
      ImporterLogger.info 'State Nil'
      ImporterLogger.info provider.id
      ImporterLogger.info sync_excel.id
      ImporterLogger.info current_row[columns[:state]]
      return nil
    end

    provider_id = provider.id
    sync_excel_id = sync_excel.id
    state_id = state.id
    Province.new(
        name: current_row[columns[:province]],
        provider_id: provider_id,
        sync_excel_id: sync_excel_id,
        state_id: state_id
    )
  end

  def build_municipality
    state = State.find_by(provider: provider, sync_excel: sync_excel, name: current_row[columns[:state]])
    unless state
      ImporterLogger.info 'State Nil'
      ImporterLogger.info provider.id
      ImporterLogger.info sync_excel.id
      ImporterLogger.info current_row[columns[:state]]
      return nil
    end

    provider_id = provider.id
    sync_excel_id = sync_excel.id
    state_id = state.id
    Municipality.new(
        name: current_row[columns[:municipality]],
        code: current_row[columns[:municipality_code]].to_i,
        provider: provider_id,
        sync_excel: sync_excel_id,
    )
  end

  def build_circunscription

  end

  def build_location

  end

  def build_precinct

  end

  def build_voting_table

  end

  def build_vote

  end

end