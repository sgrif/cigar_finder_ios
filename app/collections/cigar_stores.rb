class CigarStores
  include Enumerable
  include Delegation

  attr_reader :cigar_stores
  delegate :each, to: :cigar_stores

  def self.from_json(json)
    new(json.map { |data| CigarStore.from_hash(data) })
  end

  def initialize(cigar_stores)
    @cigar_stores = cigar_stores
  end
end
