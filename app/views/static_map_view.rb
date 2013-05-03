class StaticMapView < UIImageView
  attr_reader :location

  def initialize(location)
    initWithFrame(CGRectZero)
    @location = location
  end

  def update_image
    setImageWithURL(NSURL.URLWithString("http://maps.googleapis.com/maps/api/staticmap?sensor=true" +
      "&size=#{frame.size.width.to_i}x#{frame.size.height.to_i}" +
      "&key=AIzaSyDWBzeBlZ7hC_NUDIP6WsmpDXXmhzgLdVk" +
      "&markers=icon:http://s3.amazonaws.com/cigar-finder/map_marker.png%7C#{location.latitude}%2C#{location.longitude}"
      ))
  end
end
