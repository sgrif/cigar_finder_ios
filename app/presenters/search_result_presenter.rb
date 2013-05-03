class SearchResultPresenter < Struct.new(:search_result)
  def last_report
    if search_result.carried.nil?
      "We have no information on whether #{search_result.cigar} is carried at this location"
    else
      "Time since last report that #{search_result.cigar} is #{carried_past_tense} at this location"
    end
  end

  def carried_past_tense
    search_result.carried? ? 'carried' : 'not carried'
  end
end