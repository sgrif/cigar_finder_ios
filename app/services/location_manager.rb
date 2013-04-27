class LocationManager
  attr_accessor :last_update_location

  def location_manager
    @location_manager ||= CLLocationManager.alloc.init
  end

  def listen_for_changes
    location_manager.delegate = self
    location_manager.startMonitoringSignificantLocationChanges
  end

  def locationManager(_, didUpdateLocations: locations)
    new_location = locations.last
    if significant_change_from?(new_location)
      self.last_update_location = new_location
      update_proximity_alerts
    end
  end

  private

  def update_proximity_alerts
    NearbyStores.new(last_update_location).load do |cigar_stores|
      puts 'Creating proximity alerts for:'
      p cigar_stores
    end
  end

  def significant_change_from?(new_location)
    last_update_location.nil? || new_location.distanceFromLocation(last_update_location) > 5000
  end
end