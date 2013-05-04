class QueryUserDialog
  YES_INDEX = 1
  NO_INDEX = 0
  attr_reader :search_result

  def initialize(search_result)
    @search_result = search_result
  end

  def present
    alert.delegate = self
    alert.title = store_name
    alert.message = "Does #{store_name} carry #{search_result.cigar}?"
    alert.addButtonWithTitle('No')
    alert.addButtonWithTitle('Yes')
    alert.show
    self
  end

  def alertView(_, clickedButtonAtIndex: index)
    case index
      when YES_INDEX
        search_result.report_carried
      when NO_INDEX
        search_result.report_not_carried
    end
  end

  private

  def store_name
    search_result.cigar_store.name
  end

  def alert
    @alert ||= UIAlertView.new
  end
end