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

  def last_updated_number
    last_updated_description[/^\d+/]
  end

  def last_updated_words
    last_updated_description[/[^\d]+$/].lstrip
  end

  private

  def last_updated_description
    search_result.updated_at.stringWithTimeDifference
  end
end