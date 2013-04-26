class SearchResult < Struct.new(:cigar, :carried, :cigar_store, :updated_at)
  def cigar_store=(new_cigar_store)
    case new_cigar_store
      when Hash
        self[:cigar_store] = CigarStore.from_hash(new_cigar_store)
      else
        self[:cigar_store] = new_cigar_store
    end
  end

  def updated_at=(new_updated_at)
    case new_updated_at
      when String
        self[:updated_at] = Time.iso8601(new_updated_at)
      else
        self[:updated_at] = new_updated_at
    end
  end

  alias_method :carried?, :carried

  def report_carried
    self.carried = true
    update_carried('report_carried')
  end

  def report_not_carried
    self.carried = false
    update_carried('report_not_carried')
  end

  def update_carried(uri)
    self.updated_at = Time.now
    params = { cigar: cigar, cigar_store_id: cigar_store.id }
    BW::HTTP.post("http://cigar-finder.com/cigar_search_results/#{uri}.json", payload: params)
  end
end