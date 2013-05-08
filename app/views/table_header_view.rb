class TableHeaderView < UIView
  attr_reader :text

  def initialize(text)
    initWithFrame([[0,0],[320,30]])
    @text = text
  end

  def layoutSubviews
    label.sizeToFit
    background.frame = [[-2,0],[label.size.width + 30,30]]
  end

  private

  def label
    @label ||= UILabel.alloc.initWithFrame([[12,5],[0,0]]).tap do |label|
      label.text = text.upcase
      label.backgroundColor = :clear.uicolor
      label.textColor = :white.uicolor
      label.font = UIFont.boldSystemFontOfSize(13)
      label.layer.shadowOffset = [1,1]
      label.layer.shadowRadius = 2
      label.layer.shadowOpacity = 0.6
      addSubview(label)
    end
  end

  def background
    @background ||= UIImageView.alloc.initWithImage(background_image).tap do |image_view|
      addSubview(image_view)
      sendSubviewToBack(image_view)
    end
  end

  def background_image
    @background_image ||= UIImage.imageNamed('table_header_bg.png').resizableImageWithCapInsets([13,14,17,6])
  end
end