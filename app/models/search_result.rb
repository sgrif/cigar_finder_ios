class SearchResult < Struct.new(:cigar, :carried, :cigar_store, :updated_at)
  def cigar_store=(new_cigar_store)
    if new_cigar_store.is_a?(Hash)
      self[:cigar_store] = CigarStore.from_hash(new_cigar_store)
    end
  end

  def updated_at=(new_updated_at)
    if new_updated_at.is_a?(String)
      self[:updated_at] = Time.iso8601(new_updated_at)
    end
  end

  alias_method :carried?, :carried
end