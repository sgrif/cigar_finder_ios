class LocationListener
  include LocationManagement
  attr_accessor :last_update_location

  def listen_for_changes
    location_manager.startMonitoringSignificantLocationChanges
  end

  def locationManager(_, didUpdateLocations: locations)
    new_location = locations.last
    if significant_change_from?(new_location)
      self.last_update_location = new_location
      @store_proximity = StoreProximity.new(new_location)
      @store_proximity.monitor
    end
  end

  private

  def significant_change_from?(new_location)
    last_update_location.nil? || new_location.distanceFromLocation(last_update_location) > 5000
  end
end