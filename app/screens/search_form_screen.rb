class SearchFormScreen < ProMotion::Screen
  title 'Search'
  attr_accessor :cigars

  def on_load
    @cigars ||= []
    load_cigar_names
  end

  def will_appear
    view.backgroundColor = :white.uicolor
    navigation_controller.navigationBar.hidden = true


    @cigar_name ||= add MLPAutoCompleteTextField.new,
                      placeholder: "Type of cigar you're looking for",
                      borderStyle: :rounded.uiborderstyle,
                      delegate: self,
                      autoCompleteDataSource: self
    @cigar_name.returnKeyType = :next.uireturnkey

    @location_name ||= add UITextField.new,
                           placeholder: 'Location (Optional)',
                           borderStyle: :rounded.uiborderstyle,
                           delegate: self
    @location_name.returnKeyType = :search.uireturnkey

    @search_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Find it!', forState: :normal.uistate)
      button.on(:touch, &method(:search_tapped))
    end

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'cigar_name' => @cigar_name, 'location_name' => @location_name, 'search_button' => @search_button
      layout.metrics 'top' => 100
      layout.vertical '|-top-[cigar_name]-[location_name]-[search_button]'
      layout.horizontal '|-[cigar_name]-|'
      layout.horizontal '|-[location_name]-|'
      layout.horizontal '|-[search_button]-|'
    end
  end

  def load_cigar_names
    BW::HTTP.get('http://cigar-finder.com/cigars.json') do |response|
      if response.ok?
        self.cigars = BW::JSON.parse(response.body.to_s)
      end
    end
  end

  def search_tapped(event)
    open ResultsScreen.new(cigar_name: @cigar_name.text, location_name: @location_name.text)
  end

  def textFieldShouldReturn(text_field)
    text_field.resignFirstResponder
    case text_field
      when @cigar_name
        @location_name.becomeFirstResponder
      when @location_name
        @search_button.trigger(:touch)
    end
    false
  end

  def autoCompleteTextField(text_field, possibleCompletionsForString: string)
    cigars.select { |item| item.start_with?(string) }
  end
end
