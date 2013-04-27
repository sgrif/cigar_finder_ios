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
      update_proximity_notifications
    end
  end

  private

  def update_proximity_notifications

  end
end