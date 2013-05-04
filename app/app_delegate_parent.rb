class AppDelegateParent < ProMotion::AppDelegateParent
  def application(app, didReceiveLocalNotification: notification)
    if app.applicationState == UIApplicationStateInactive
      on_notification_tapped(notification) if respond_to?(:on_notification_tapped)
    end
  end
end
