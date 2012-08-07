# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cal/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mike Krisher"]
  gem.email         = ["mike@mikekrisher.com"]
  gem.description   = %q{cal is a Ruby library for displaying beautiful calendars}
  gem.summary       = %q{cal is a Ruby library for displaying nice looking and customizable calendars using standards}
  gem.homepage      = ""

  gem.add_development_dependency("rspec", ["~> 2.9"])
  gem.add_development_dependency("guard-rspec")
  gem.add_development_dependency("pry")

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cal"
  gem.require_paths = ["lib"]
  gem.version       = Cal::VERSION

  gem.add_dependency 'activesupport'
end
