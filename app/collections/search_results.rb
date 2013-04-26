class SearchResults
  include Enumerable
  include Delegation

  attr_reader :results
  delegate :each, to: :results

  def self.from_json(json)
    new(json.map { |hash| SearchResult.from_hash(hash) })
  end

  def initialize(results)
    @results = results
  end

  def resort
    @carried, @not_carried, @no_information = nil
  end

  def carried
    @carried ||= results.select(&:carried?)
  end

  def not_carried
    @not_carried ||= results.select { |result| result.carried == false }
  end

  def no_information
    @no_information ||= results - carried - not_carried
  end
end