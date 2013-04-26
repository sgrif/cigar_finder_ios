class SearchFormScreen < ProMotion::Screen
  def on_load
    view.backgroundColor = :white.uicolor

    @cigar_name = UITextField.new
    @cigar_name.placeholder = "Type of cigar you're looking for"
    @cigar_name.textAlignment = :center.uitextalignment
    @cigar_name.borderStyle = :rounded.uiborderstyle
    @cigar_name.delegate = self

    @location_name = UITextField.new
    @location_name.placeholder = 'Location (Optional)'
    @location_name.textAlignment = :center.uitextalignment
    @location_name.borderStyle = :rounded.uiborderstyle
    @location_name.delegate = self

    @search_button = UIButton.rounded_rect
    @search_button.setTitle('Find it!', forState: :normal.uistate)
    @search_button.on(:touch, &method(:search_tapped))

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'cigar_name' => @cigar_name, 'location_name' => @location_name, 'search_button' => @search_button
      layout.metrics 'top' => 200
      layout.vertical '|-top-[cigar_name]-[location_name]-[search_button]'
      layout.horizontal '|-[cigar_name]-|'
      layout.horizontal '|-[location_name]-|'
      layout.horizontal '|-[search_button]-|'
    end
  end

  def will_appear
    navigation_controller.navigationBar.hidden = true
  end

  def search_tapped(event)
    open ResultsScreen.new(cigar_name: @cigar_name.text, location_name: @location_name.text)
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
    false
  end
end
