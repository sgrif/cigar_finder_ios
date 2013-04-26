class AppDelegate < ProMotion::AppDelegateParent
  def on_load(app, options)
    open_root_screen SearchFormScreen.new(nav_bar: true)
  end
end
