class CigarStore < Struct.new(:id, :name, :latitude, :longitude, :address)
  def map_url
    encoded_name = name.dup.to_url_encoded.gsub('%20', '+')
    "http://maps.apple.com/?ll=#{latitude},#{longitude}&q=#{encoded_name}"
  end
end