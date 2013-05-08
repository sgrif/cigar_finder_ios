class TableItemView < UITableViewCell
  def layoutSubviews
    self.frame = [[10,frame.origin.y], frame.size]
    textLabel.textColor = '#94312D'.to_color
    detailTextLabel.textColor = '#46382B'.to_color
    super
  end
end