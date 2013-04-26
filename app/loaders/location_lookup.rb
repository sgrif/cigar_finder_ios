class LocationLookup
  attr_reader :location_name
  def initialize(location_name)
    @location_name = location_name
  end

  def load(&block)
    BW::Location.get_once(&block)
  end
end