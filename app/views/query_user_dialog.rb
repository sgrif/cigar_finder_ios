class QueryUserDialog
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
    puts "index #{index} was clicked"
  end

  private

  def store_name
    search_result.cigar_store.name
  end

  def alert
    @alert ||= UIAlertView.new
  end
end