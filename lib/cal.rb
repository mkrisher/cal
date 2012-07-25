require "cal/version"
require "cal/rails"
require 'active_support/all'

module Cal
  extend self

  def display(year = Date.today.year, month = Date.today.month)
    "#{year} - #{month} - #{Date.civil(year, month).beginning_of_month}"
  end
end
