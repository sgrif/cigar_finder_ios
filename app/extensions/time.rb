class Time
  class << self
    alias original_iso8601 iso8601
  end

  def self.iso8601(time)
    original_iso8601(time) or
        cached_date_formatter("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'").dateFromString(time)
  end
end