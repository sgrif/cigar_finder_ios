class StoreProximityNotification
  attr_reader :cigar_store

  def initialize(cigar_store)
    @cigar_store = cigar_store
  end

  def present
    notification.alertBody = "You are at #{cigar_store.name}!"
    notification.soundName = UILocalNotificationDefaultSoundName
    App.shared.presentLocalNotificationNow(notification)
  end

  private

  def notification
    @notification ||= UILocalNotification.new
  end
end