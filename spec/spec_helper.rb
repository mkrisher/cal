require 'stub'
require 'cal'
require "rspec"
require 'pry'

RSpec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end
