class AppDelegate < ProMotion::AppDelegateParent
  def on_load(app, options)
    location_manager.listen_for_changes
    open_root_screen SearchFormScreen.new(nav_bar: true)
  end

  def location_manager
    @location_manager ||= LocationListener.new
  end
end
