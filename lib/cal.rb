require "cal/version"
require "cal/rails"
require "cal/calculations"
require "active_support/all"

module Cal
  extend self

  def display(options = {})
    @year   = options[:year]  || Date.today.year
    @month  = options[:month] || Date.today.month

    Cal::Calculations.draw_calendar({year: @year, month: @month})
  end
end
