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

  private

  def load_data
    data = {cigar: cigar_name, latitude: 35.0844, longitude: -106.6506}
    BW::HTTP.get('http://cigar-finder.com/cigar_search_results.json', payload: data) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_s)
        carried = json.select { |item| item['carried'] == true }
        not_carried = json.select { |item| item['carried'] == false }
        no_information = json.select { |item| item['carried'].nil? }
        new_data = []
        if carried.any?
          new_data << { title: 'Carried', cells: carried.map { |item| { title: item['cigar_store']['name'] } } }
        end
        if not_carried.any?
          new_data << { title: 'Not Carried', cells: not_carried.map { |item| { title: item['cigar_store']['name'] } } }
        end
        if no_information.any?
          new_data << { title: 'No Information', cells: no_information.map { |item| { title: item['cigar_store']['name'] } } }
        end
        self.table_data = new_data
      end
    end
  end
end