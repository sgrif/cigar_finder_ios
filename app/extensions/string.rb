class String
  def titleize
    gsub('_', ' ').gsub(/ (\w)/) { |match| match.upcase }.gsub(/^(\w)/) { |match| match.upcase }
  end
  alias_method :title_case, :titleize
end