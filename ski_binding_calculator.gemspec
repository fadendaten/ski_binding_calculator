$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'ski_binding_calculator/version'

Gem::Specification.new do |s|
  s.name        = 'ski_binding_calculator'
  s.version     = SkiBinding::VERSION
  s.summary     = "Ski binding release value calculator (ISO 11088)"
  s.description = "Calculates the initial indicator value (z-value) according to ISO 11088 standard."
  s.authors     = ["Jonas Ruef, Felix Langenegger"]
  s.email       = 'support@fadendaten.ch'
  s.homepage    = 'http://fadendaten.ch'
  s.license     = 'MIT'
  
  s.add_dependency "activesupport", "~> 4.0.0"
  s.add_development_dependency "rspec", "~> 2.14.1"
  s.add_development_dependency "spork", "~> 0.9.2"
  s.add_development_dependency "simplecov", "~> 0.7.1"
  s.add_development_dependency "timecop", "~> 0.6.3"
  s.add_development_dependency "fuubar", "~> 1.2.1"

  s.files =  Dir.glob("{config,lib,spec}/**/*")
  s.files += %w(Rakefile ski_binding_calculator.gemspec)
end
