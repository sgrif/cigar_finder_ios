class StoreProximityNotification
  attr_reader :cigar_store

  def initialize(cigar_store)
    @cigar_store = cigar_store
  end

  def present
    determine_cigar do |search_result|
      App.shared.cancelAllLocalNotifications
      notification.alertBody = "Does #{search_result.cigar_store.name} carry #{search_result.cigar}?"
      notification.soundName = UILocalNotificationDefaultSoundName
      App.shared.presentLocalNotificationNow(notification)
    end
    self
  end

  private

  def determine_cigar(&block)
    BW::HTTP.get("#{cigar_store.url}/missing_information.json") do |response|
      if response.ok?
        data = BW::JSON.parse(response.body.to_s)
        cigar = data['cigar']
        block.call(SearchResult.from_hash(cigar_store: cigar_store, cigar: cigar))
      end
    end
  end

  def notification
    @notification ||= UILocalNotification.new
  end
end