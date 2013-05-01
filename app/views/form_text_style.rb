module FormTextStyle
  def apply_style
    layer.cornerRadius = 4.0
    layer.masksToBounds = true
    layer.borderColor = :black.uicolor.CGColor
    layer.borderWidth = 1.0
    self.backgroundColor = :black.uicolor(0.5)
    self.textColor = :white.uicolor
  end

  def padding_for_bounds(bounds)
    CGRectInset(bounds, 10, 10)
  end
end
