Gem::Specification.new do |s|
  s.name        = 'ski_binding_calculator'
  s.version     = '0.0.1'
  s.date        = '2013-07-28'
  s.summary     = "Ski Binding Calculator"
  s.description = "A little gem to calculate the z-value accord to the iso 11088 norm."
  s.authors     = ["Jonas Ruef, Felix Langenegger"]
  s.email       = 'support@fadendaten.ch'
  s.homepage    = 'http://fadendaten.ch'
  
  s.add_development_dependency "rspec", "~> 2.14.1"
  s.add_development_dependency "spork", "~> 0.9.2"

  s.files =  Dir.glob("{config,lib,spec}/**/*")
  s.files += %w(Rakefile ski_binding_calculator.gemspec)
end
