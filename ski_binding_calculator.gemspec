Gem::Specification.new do |s|

  s.name        = 'ski_binding_calculator'
  s.version     = '0.5.1'
  s.date        = '2013-08-04'
  s.summary     = "Ski Binding Calculator"
  s.description = "calculate the z-value, forward pressure and turning
                   moment according to ISO 11088."
  s.authors     = ["Jonas Ruef, Felix Langenegger"]
  s.email       = 'support@fadendaten.ch'
  s.homepage    = 'http://fadendaten.ch'
  s.license     = 'MIT'
  
  s.add_development_dependency "rspec", "~> 2.14.1"
  s.add_development_dependency "spork", "~> 0.9.2"
  s.add_development_dependency "simplecov", "~> 0.7.1"

  s.files =  Dir.glob("{config,lib,spec}/**/*")
  s.files += %w(Rakefile ski_binding_calculator.gemspec)
end
