class SearchResultPresenter < Struct.new(:search_result)
  def last_report
    unless search_result.carried.nil?
      ['It was last reported that', search_result.cigar_store.name, carried_present_tense,
        search_result.cigar, search_result.updated_at.stringWithTimeDifference].join(' ')
    end
  end

  def carried_present_tense
    search_result.carried? ? 'carries' : 'does not carry'
  end
end