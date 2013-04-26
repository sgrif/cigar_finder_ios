class SearchResults
  include Enumerable

  attr_reader :results

  def self.from_json(json)
    new(json.map { |hash| SearchResult.from_hash(hash) })
  end

  def initialize(results)
    @results = results
  end

  def carried
    @carried ||= results.select(&:carried?)
  end

  def not_carried
    @not_carried ||= results.select { |result| result.carried == false }
  end

  def no_information
    results - carried - not_carried
  end
end