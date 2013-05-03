class LastReportedView < UIView
  attr_reader :search_result
  def initialize(search_result)
    initWithFrame(CGRectZero)
    @search_result = search_result

    self.backgroundColor = BW.rgba_color(0x4E, 0x3C, 0x2F, 0.8)
  end

  def layoutSubviews
    Motion::Layout.new do |layout|
      layout.view self
      layout.subviews 'description' => description
      layout.horizontal '|-[description]-|'
      layout.vertical '|-[description]-|'
    end
    description.preferredMaxLayoutWidth = bounds.size.width - 40
    super
  end

  def description
    @description ||= UILabel.new.tap do |label|
      label.text = search_result_presenter.last_report
      label.lineBreakMode = NSLineBreakByWordWrapping
      label.numberOfLines = 0
      label.backgroundColor = :clear.uicolor
      label.textColor = '#F6F4F3'.to_color
      label.font = UIFont.systemFontOfSize(12)
    end
  end

  def search_result_presenter
    @search_result_presenter ||= SearchResultPresenter.new(search_result)
  end
end