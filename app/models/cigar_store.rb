class CigarStore < Struct.new(:id, :name, :latitude, :longitude, :address, :phone_number, :created_at, :updated_at)
  alias_method :to_s, :name

  def map_url
    encoded_name = name.dup.to_url_encoded.gsub('%20', '+')
    "http://maps.apple.com/?ll=#{latitude},#{longitude}&q=#{encoded_name}"
  end

  def directions_url
    encoded_address = address.dup.to_url_encoded.gsub('%20', '+')
    "http://maps.apple.com/?daddr=#{encoded_address}"
  end

  def phone_url
    "tel:#{phone_number}".gsub(' ', '-')
  end

  def coordinate
    [latitude, longitude]
  end

  def url
    "http://cigar-finder.com/cigar_stores/#{id}"
  end
end
