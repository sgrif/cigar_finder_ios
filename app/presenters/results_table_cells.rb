class ResultsTableCells
  include Enumerable
  include Delegation

  attr_reader :results

  delegate :each, to: :cells

  def initialize(results)
    @results = results
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
    results.send(macro).map do |item|
      {
          title: item.cigar_store.name,
          subtitle: "Last reported #{item.updated_at.stringWithTimeDifference}",
          cell_style: :subtitle.uitablecellstyle
      }
    end
  end
end