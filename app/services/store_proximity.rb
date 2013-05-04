# Handles region monitoring for a set of stores
class StoreProximity
  include LocationManagement

  attr_reader :location
  attr_accessor :cigar_stores

  def initialize(location)
    @location = location
  end

  def monitor
    NearbyStores.new(location).load do |cigar_stores|
      self.cigar_stores = cigar_stores
      update_proximity_alerts
    end
  end

  def locationManager(_, didEnterRegion: region)
    cigar_store = cigar_stores.find { |store| store.name == region.identifier }
    @notification = StoreProximityNotification.new(cigar_store).present
  end

  private

  def update_proximity_alerts
    remove_proximity_alerts
    create_proximity_alerts
  end

  def create_proximity_alerts
    cigar_stores.map do |cigar_store|
      region = MonitoredRegion.new(cigar_store)
      location_manager.startMonitoringForRegion(region)
    end
  end

  def remove_proximity_alerts
    location_manager.monitoredRegions.allObjects.map do |monitored_region|
      location_manager.stopMonitoringForRegion(monitored_region)
    end
  end
end