class MonitoredRegion < CLRegion
  attr_reader :target

  def initialize(target)
    @target = target
    initCircularRegionWithCenter(target.coordinate, radius: 50, identifier: target.to_s)
  end
end