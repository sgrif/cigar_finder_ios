module LocationManagement
  def location_manager
    @location_manager ||= CLLocationManager.alloc.init.tap do |manager|
      manager.delegate = self
    end
  end
end
