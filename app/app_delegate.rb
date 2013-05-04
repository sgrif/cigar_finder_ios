class AppDelegate < AppDelegateParent
  def on_load(app, options)
    location_manager.listen_for_changes
    open_root_screen SearchFormScreen.new(nav_bar: true)
    window.backgroundColor = background
  end

  # @param [UILocalNotification] notification
  # @param [UIApplication] app
  def on_notification_tapped(app, notification)
    search_result = SearchResult.deserialize(notification.userInfo['search_result'])
    @query_dialog = QueryUserDialog.new(search_result).present
    app.cancelLocalNotification(notification)
  end

  def location_manager
    @location_manager ||= LocationListener.new
  end

  def background
    UIColor.colorWithPatternImage(background_image)
  end

  def background_image
    UIImage.imageNamed('background.png')
  end
end
