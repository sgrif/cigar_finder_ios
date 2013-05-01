class FormTextInput < UITextField
  include FormTextStyle

  def init
    super
    apply_style
    self
  end

  def textRectForBounds(bounds)
    padding_for_bounds(bounds)
  end

  def editingRectForBounds(bounds)
    padding_for_bounds(bounds)
  end
end