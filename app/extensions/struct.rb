class Struct
  def self.from_hash(hash)
    new.tap do |result|
      hash.each do |key, value|
        result.send("#{key}=", value)
      end
    end
  end

  def initWithCoder(decoder)
    init
    each_pair do |attr, _|
      self.send("#{attr}=", decoder.decodeObjectForKey(attr.to_s))
    end
    self
  end

  def encodeWithCoder(coder)
    each_pair do |attr, value|
      coder.encodeObject(value, forKey: attr.to_s)
    end
  end

  # Dear future Sean: Serialization is hard...
  def serialize
    Marshal.dump(self)
  end

  def self.deserialize(data)
    Marshal.load(data)
  end
end