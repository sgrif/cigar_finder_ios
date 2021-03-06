class AutoCompleteFormTextInput < MLPAutoCompleteTextField
  include FormTextStyle

  def initialize
    super
    apply_style
  end

  def textRectForBounds(bounds)
    padding_for_bounds(bounds)
  end

  def editingRectForBounds(bounds)
    padding_for_bounds(bounds)
  end
end