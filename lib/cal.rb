require "cal/version"

module Cal
  extend self

  def display(year = Date.today.year, month = Date.today.month)
    "#{year} - #{month}"
  end
end
