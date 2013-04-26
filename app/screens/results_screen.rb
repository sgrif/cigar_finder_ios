class ResultsScreen < ProMotion::GroupedTableScreen
  attr_accessor :cigar_name, :location_name, :results
  attr_reader :table_data

  def on_load
    @table_data ||= []
    load_data
  end

  def table_data=(new_data)
    @table_data = new_data
    update_table_data
  end

  def will_appear
    self.title = cigar_name
    navigation_controller.navigationBar.hidden = false
  end

  def search_result_tapped(args = {})
    open ResultDetailScreen.new(search_result: args[:search_result])
  end

  def on_return(args = {})
    search_result = args[:search_result]
    if search_result
      args[:report_carried] ? search_result.report_carried : search_result.report_not_carried
      table_data.resort
      update_table_data
    end
  end

  private

  def load_data
    data = {cigar: cigar_name, latitude: 35.0844, longitude: -106.6506}
    BW::HTTP.get('http://cigar-finder.com/cigar_search_results.json', payload: data) do |response|
      if response.ok?
        self.results = SearchResults.from_json(BW::JSON.parse(response.body.to_s))
        self.table_data = ResultsTableCells.new(results)
      end
    end
  end
end