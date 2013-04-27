# Responsible for querying the API for nearby stores
class NearbyStores
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def load(&block)
    data = { latitude: location.latitude, longitude: location.longitude }
    BW::HTTP.get('http://cigar-finder.com/cigar_stores/nearby.json', payload: data) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_s)
        block.call(CigarStores.from_json(json))
      end
    end
  end
end
