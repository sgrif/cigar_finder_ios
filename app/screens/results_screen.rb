class ResultsScreen < ProMotion::Screen
  include ProMotion::MotionTable::SectionedTable

  attr_accessor :cigar_name, :location_name, :results
  attr_reader :table_data, :table_view

  def on_load
    @table_data ||= []
    @image_view = add UIImageView.alloc.initWithImage(UIImage.imageNamed('table_view_background'))
    @table_view = add UITableView.alloc.initWithFrame([[22,15],[268,390]])
    @table_view.contentInset = [15,0,0,0]
    @table_view.backgroundColor = :clear.uicolor
    @table_view.dataSource = self
    @table_view.delegate = self
    #@table_view.separatorStyle = UITableViewCellSeparatorStyleNone
    load_data
  end

  def table_data=(new_data)
    @table_data = new_data
    update_table_view_data(new_data)
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
      update_table_view_data(table_data)
    end
  end

  def tableView(_, viewForHeaderInSection: section)
    TableHeaderView.new(header_text_for(section))
  end

  def tableView(_, heightForHeaderInSection: section)
    TableHeaderView::HEIGHT
  end

  private

  def header_text_for(section)
    table_data.title_for(section)
  end

  def load_data
    LocationLookup.new(location_name).load do |location|
      data = {cigar: cigar_name, latitude: location.latitude, longitude: location.longitude}
      BW::HTTP.get('http://cigar-finder.com/cigar_search_results.json', payload: data) do |response|
        if response.ok?
          self.results = SearchResults.from_json(BW::JSON.parse(response.body.to_s))
          self.table_data = ResultsTableCells.new(results)
        end
      end
    end
  end
end