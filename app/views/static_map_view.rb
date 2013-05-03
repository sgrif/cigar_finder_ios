class StaticMapView < UIImageView
  attr_reader :location

  def initialize(location)
    initWithFrame(CGRectZero)
    @location = location
  end

  def update_image
    if Device.retina?
      scale = 2
      icon = "http://s3.amazonaws.com/cigar-finder/map_marker_ios.png"
    else
      scale = 1
      icon = "http://s3.amazonaws.com/cigar-finder/map_marker_ios.png"
    end
    setImageWithURL(NSURL.URLWithString("http://maps.googleapis.com/maps/api/staticmap?sensor=true" +
      "&size=#{frame.size.width.to_i}x#{frame.size.height.to_i}" +
      "&scale=#{scale}" +
      "&key=AIzaSyDWBzeBlZ7hC_NUDIP6WsmpDXXmhzgLdVk" +
      "&markers=icon:#{icon}%7C#{location.latitude}%2C#{location.longitude}"
      ))
  end
end
