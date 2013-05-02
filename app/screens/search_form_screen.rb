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

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews 'logo' => logo, 'cigar_name' => cigar_name, 'location_name' => location_name,
                      'search_button' => search_button, 'near' => near_label, 'separator1' => separator_left,
                      'separator2' => separator_right
      layout.metrics 'padding' => 35, 'button_height' => 38, 'input_height' => FormTextStyle::HEIGHT, 'near_padding' => 12
      layout.vertical '|-padding-[logo]-padding-[cigar_name(==input_height)]'
      layout.vertical '[cigar_name]-near_padding-[near]-near_padding-[location_name]'
      layout.vertical '[location_name(==input_height)]-padding-[search_button(==38)]'
      layout.horizontal '|-[cigar_name]-|'
      layout.horizontal '|-[separator1]-[near(>=40)]-[separator2(==separator1)]-|'
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

  def search_button
    @search_button ||= UIButton.rounded_rect.tap do |button|
      button.setTitle('Find it!', forState: :normal.uistate)
      button.on(:touch, &method(:search_tapped))
      background = UIImage.imageNamed('button_background')
      button.setBackgroundImage(background, forState: :normal.uistate)
      button.setTitleColor(:white.uicolor, forState: :normal.uistate)
      button.font = UIFont.systemFontOfSize(14)
    end
  end

  def near_label
    @near_label ||= add UILabel.new,
      text: 'near',
      textColor: '#FEFFBF'.to_color,
      backgroundColor: :clear.uicolor,
      textAlignment: :center.uitextalignment
  end

  def separator_image
    @separator_image ||= UIImage.imageNamed('separator.png')
  end

  [:separator_left, :separator_right].each do |method|
    define_method(method) do
      UIImageView.alloc.initWithImage(separator_image)
    end
  end
end
