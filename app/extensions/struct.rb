class Struct
  def self.from_hash(hash)
    new.tap do |result|
      hash.each do |key, value|
        result.send("#{key}=", value)
      end
    end
  end
end