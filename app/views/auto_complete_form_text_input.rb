class AutoCompleteFormTextInput < MLPAutoCompleteTextField
  def initialize
    layer.cornerRadius = 4.0
    layer.masksToBounds = true
    layer.borderColor = :black.uicolor.CGColor
    layer.borderWidth = 2.0
    self.backgroundColor = :black.uicolor(0.5)
  end

  def textRectForBounds(bounds)
    CGRectInset(bounds, 10, 10)
  end

  def editingRectForBounds(bounds)
    textRectForBounds(bounds)
  end
end