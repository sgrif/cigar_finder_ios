class ResultsTableCells
  include Enumerable
  include Delegation

  attr_reader :results

  delegate :each, to: :cells
  delegate :length, :at, to: :to_a

  def initialize(results)
    @results = results
  end

  def title_for(section)
    cells[section][:title]
  end

  def resort
    @cells = nil
    results.resort
  end

  def cells
    @cells ||= unfiltered_cells.reject(&:nil?)
  end

  def unfiltered_cells
    [:carried, :not_carried, :no_information].map do |macro|
      results_group = formatted_results(macro)
      if results_group.any?
        {
            title: macro.to_s.title_case,
            cells: results_group
        }
      end
    end
  end

  def formatted_results(macro)
    results.send(macro).map do |search_result|
      {
          title: search_result.cigar_store.name,
          subtitle: search_result.carried.nil? ? '' : "Last reported #{search_result.updated_at.stringWithTimeDifference}",
          cell_style: :subtitle.uitablecellstyle,
          cell_class: TableItemView,
          action: :search_result_tapped,
          arguments: { search_result: search_result }
      }
    end
  end
end