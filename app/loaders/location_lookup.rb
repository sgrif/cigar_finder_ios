class LocationLookup
  attr_reader :location_name
  def initialize(location_name)
    @location_name = location_name
  end

  def load(&block)
    if location_name.blank?
      BW::Location.get_once(&block)
    else
      geocode_location(&block)
    end
  end

  def geocode_location(&block)
    CLGeocoder.new.geocodeAddressString(location_name, completionHandler: lambda { |locations, _|
      block.call(locations.first.location)
    })
  end
end