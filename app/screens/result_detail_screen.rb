class ResultDetailScreen < ProMotion::Screen
  attr_accessor :search_result

  def will_appear
    self.title = search_result.cigar_store.name
    view.insertSubview(background, atIndex: 0)

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'store_name' => store_name, 'store_address' => store_address,
                      'map_button' => map_button, 'directions_button' => directions_button, 'call_button' => call_button,
                      'last_reported' => last_reported, 'report_carried' => report_carried,
                      'report_not_carried' => report_not_carried
      layout.vertical '|-[store_name]-[store_address]-[map_button]', 0
      layout.horizontal '|-[store_name]-|'
      layout.horizontal '|-[store_address]-|'
      layout.horizontal '|-[map_button]-[directions_button(==map_button)]-[call_button(==map_button)]-|'
      layout.horizontal '|-[last_reported]-|'
      layout.horizontal '|-[report_carried]-[report_not_carried(==report_carried)]-|'
      layout.vertical '[last_reported]-[report_carried]-|', 0
    end
  end

  def updateViewConstraints
    super
    [store_address, last_reported].each do |label|
      label.preferredMaxLayoutWidth = view.bounds.size.width - 40
    end
  end

  private

  def background
    background_image = UIImage.imageNamed('detail_background')
    UIImageView.alloc.initWithImage(background_image)
  end

  def search_result_presenter
    @search_result_presenter ||= SearchResultPresenter.new(search_result)
  end

  def store_name
    @store_name ||= add UILabel.new,
                        text: search_result.cigar_store.name,
                        backgroundColor: :clear.uicolor,
                        textColor: '#95312E'.to_color,
                        font: UIFont.systemFontOfSize(18)
  end

  def store_address
    @store_address ||= add UILabel.new,
                           text: search_result.cigar_store.address,
                           lineBreakMode: NSLineBreakByWordWrapping,
                           numberOfLines: 0,
                           backgroundColor: :clear.uicolor
  end

  def map_button
    @map_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Map', forState: :normal.uistate)
      button.on(:touch) do
        App.open_url(search_result.cigar_store.map_url)
      end
    end
  end

  def directions_button
    @directions_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Directions', forState: :normal.uistate)
      button.on(:touch) do
        App.open_url(search_result.cigar_store.directions_url)
      end
    end
  end

  def call_button
    @call_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Call', forState: :normal.uistate)
    end
  end

  def last_reported
    @last_reported ||= add UILabel.new,
                           text: search_result_presenter.last_report,
                           lineBreakMode: NSLineBreakByWordWrapping,
                           numberOfLines: 0,
                           backgroundColor: :clear.uicolor
  end

  def report_carried
    @report_carried ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Report Carried', forState: :normal.uistate)
      button.on(:touch) do
        close(search_result: search_result, report_carried: true)
      end
    end
  end

  def report_not_carried
    @report_not_carried ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Report Not Carried', forState: :normal.uistate)
      button.on(:touch) do
        close(search_result: search_result, report_carried: false)
      end
    end
  end
end