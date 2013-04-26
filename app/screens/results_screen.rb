class ResultsScreen < ProMotion::GroupedTableScreen
  attr_accessor :cigar_name, :location_name
  attr_reader :table_data

  def on_load
    self.title = cigar_name
    @table_data ||= []
    load_data
  end

  def table_data=(new_data)
    @table_data = new_data
    update_table_data
  end

  def will_appear
    navigation_controller.navigationBar.hidden = false
    navigation_controller.navigationBar.topItem.title = 'Back'
  end

  def search_result_tapped(args = {})
    puts "#{args[:search_result].cigar_store.name} tapped!"
  end

  private

  def load_data
    data = {cigar: cigar_name, latitude: 35.0844, longitude: -106.6506}
    BW::HTTP.get('http://cigar-finder.com/cigar_search_results.json', payload: data) do |response|
      if response.ok?
        results = SearchResults.from_json(BW::JSON.parse(response.body.to_s))
        self.table_data = ResultsTableCells.new(results).to_a
      end
    end
  end
end