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
      if search_result.carried.nil?
        layout.subviews 'description' => description
        layout.horizontal '|-[description]-|'
        description.preferredMaxLayoutWidth = bounds.size.width - 40
      else
        layout.subviews 'description' => description, 'block' => updated_at_container
        layout.horizontal '|-[description]-10-[block(==80)]|'
        layout.vertical '|[block]|'

        Motion::Layout.new do |layout|
          layout.view updated_at_container
          layout.subviews 'number' => updated_at_number, 'words' => updated_at_words
          layout.metrics 'top' => '>=14', 'bottom' => '>=14'
          layout.horizontal '|[number]|'
          layout.horizontal '|[words]|'
          layout.vertical '|-[number][words]-|'
        end
        description.preferredMaxLayoutWidth = bounds.size.width - 120
      end
      layout.vertical '|-[description]-|'
    end
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

  def updated_at_container
    @updated_at_container ||= UIView.new.tap do |view|
      view.backgroundColor = '#483C31'.to_color
    end
  end

  def updated_at_number
    @updated_at_number ||= UILabel.new.tap do |label|
      label.text = search_result_presenter.last_updated_number
      label.textColor = '#F6F4F3'.to_color
      label.textAlignment = :center.uitextalignment
      label.font = UIFont.systemFontOfSize(25)
      label.backgroundColor = :clear.uicolor
    end
  end

  def updated_at_words
    @updated_at_words ||= UILabel.new.tap do |label|
      label.text = search_result_presenter.last_updated_words.upcase
      label.textColor = BW.rgba_color(0xF6, 0xF4, 0xF3, 0.5)
      label.textAlignment = :center.uitextalignment
      label.font = UIFont.systemFontOfSize(12)
      label.backgroundColor = :clear.uicolor
    end
  end

  def search_result_presenter
    @search_result_presenter ||= SearchResultPresenter.new(search_result)
  end
end