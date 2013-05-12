class ResultDetailScreen < ProMotion::Screen
  attr_accessor :search_result

  def will_appear
    self.title = search_result.cigar_store.name
    view.insertSubview(background, atIndex: 0)

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'store_name' => store_name, 'store_address' => store_address,
                      'map_button' => map_button, 'directions_button' => directions_button, 'call_button' => call_button,
                      'map_image' => map_image, 'last_reported' => last_reported
      layout.metrics 'padding_top' => 32, 'padding_side' => 36, 'padding_bottom' => 14
      layout.vertical '|-padding_top-[store_name][store_address]-[map_button(==47)]', 0
      layout.horizontal '|-padding_side-[store_name]-padding_side-|'
      layout.horizontal '|-padding_side-[store_address]-padding_side-|'
      layout.horizontal '|-[map_button][directions_button(==map_button)][call_button(==map_button)]-|'
      layout.horizontal '|-[last_reported]-|'
      layout.horizontal '|-21-[map_image]-21-|'
      layout.vertical '[map_button]-[map_image]-padding_bottom-|', 0
      layout.vertical '[last_reported]-padding_bottom-|'
    end
  end

  def on_appear
    map_image.update_image
  end

  def updateViewConstraints
    super
    store_address.preferredMaxLayoutWidth = view.bounds.size.width - 40
  end

  private

  def background
    background_image = UIImage.imageNamed('detail_background')
    UIImageView.alloc.initWithImage(background_image)
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
                           backgroundColor: :clear.uicolor,
                           textColor: '#46382B'.to_color,
                           font: UIFont.systemFontOfSize(12)
  end

  def map_button
    @map_button ||= UIButton.new.tap do |button|
      button.setBackgroundImage(UIImage.imageNamed('button_map'), forState: :normal.uistate)
      button.on(:touch) do
        App.open_url(search_result.cigar_store.map_url)
      end
    end
  end

  def directions_button
    @directions_button ||= UIButton.new.tap do |button|
      button.setBackgroundImage(UIImage.imageNamed('button_directions'), forState: :normal.uistate)
      button.on(:touch) do
        App.open_url(search_result.cigar_store.directions_url)
      end
    end
  end

  def call_button
    @call_button ||= UIButton.new.tap do |button|
      button.setBackgroundImage(UIImage.imageNamed('button_call'), forState: :normal.uistate)
      button.on(:touch) do
        puts search_result.cigar_store.phone_url
        App.open_url(search_result.cigar_store.phone_url)
      end
    end
  end

  def last_reported
    @last_reported ||= LastReportedView.new(search_result)
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

  def map_image
    @map_image ||= StaticMapView.new(search_result.cigar_store)
  end
end
