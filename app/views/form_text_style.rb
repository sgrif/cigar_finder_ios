module FormTextStyle
  HEIGHT = 39

  def apply_style
    self.background = UIImage.imageNamed('form_input.png')
    self.textColor = :white.uicolor
    self.font = UIFont.systemFontOfSize(14)
  end

  def padding_for_bounds(bounds)
    CGRectInset(bounds, 10, 10)
  end
end
