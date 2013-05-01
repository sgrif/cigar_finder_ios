class SearchFormScreen < ProMotion::Screen
  title 'Search'
  attr_accessor :cigars

  def on_load
    @cigars ||= []
    load_cigar_names
  end

  def will_appear
    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'keyboardWillShow:', name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'keyboardWillHide:', name: UIKeyboardWillHideNotification, object: nil)
    navigation_controller.navigationBar.hidden = true

    @search_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Find it!', forState: :normal.uistate)
      button.on(:touch, &method(:search_tapped))
    end

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'logo' => logo, 'cigar_name' => cigar_name, 'location_name' => location_name, 'search_button' => @search_button
      layout.metrics 'padding' => 35
      layout.vertical '|-padding-[logo]-padding-[cigar_name]-[location_name]-padding-[search_button]'
      layout.horizontal '|-[cigar_name]-|'
      layout.horizontal '|-[location_name]-|'
      layout.horizontal '|-[search_button]-|'
    end
  end

  def on_appear
    gradient = CAGradientLayer.layer
    gradient.frame = @search_button.bounds
    gradient.colors = ['#943536'.to_color.CGColor, '#701F1B'.to_color.CGColor]
    @search_button.layer.insertSublayer(gradient, atIndex: 0)
  end

  def load_cigar_names
    BW::HTTP.get('http://cigar-finder.com/cigars.json') do |response|
      if response.ok?
        self.cigars = BW::JSON.parse(response.body.to_s)
      end
    end
  end

  def search_tapped(event)
    view.endEditing(true)
    unless @cigar_name.text.blank?
      open ResultsScreen.new(cigar_name: @cigar_name.text, location_name: @location_name.text)
    end
  end

  def textFieldShouldReturn(text_field)
    case text_field
      when @cigar_name
        @location_name.becomeFirstResponder
      when @location_name
        @search_button.trigger(:touch)
    end
    false
  end

  def autoCompleteTextField(text_field, possibleCompletionsForString: string)
    cigars.select { |item| item.downcase.start_with?(string.downcase) }
  end

  private

  def logo
    @logo ||= add UIImageView.alloc.initWithImage(logo_image)
  end

  def logo_image
    @logo_image ||= UIImage.imageNamed('logo_form')
  end

  def cigar_name
    @cigar_name ||= AutoCompleteFormTextInput.new.tap do |input|
      input.placeholder = "Type of cigar you're looking for"
      input.delegate = self
      input.autoCompleteDataSource = self
      input.returnKeyType = :next.uireturnkey
      input.autocorrectionType = UITextAutocorrectionTypeNo
    end
  end

  def location_name
    @location_name ||= FormTextInput.new.tap do |input|
      input.placeholder = 'Location (Optional)'
      input.delegate = self
      input.returnKeyType = :search.uireturnkey
    end
  end

  def keyboardWillShow(notification)
    UIView.animateWithDuration(0.3, animations: lambda {
      view.setFrame([[0,-150], view.frame.size])
    })
  end

  def keyboardWillHide(notification)
    UIView.animateWithDuration(0.3, animations: lambda {
      view.setFrame([[0,0], view.frame.size])
    })
  end
end
