class AppDelegate < ProMotion::AppDelegateParent
  def on_load(app, options)
    open SearchFormScreen.new
  end
end
