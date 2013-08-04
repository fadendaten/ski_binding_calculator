require 'rubygems'
require 'spork'

Spork.prefork do
  require 'rspec'
  require 'simplecov'
  SimpleCov.start

  unless defined?(SPEC_ROOT)
    SPEC_ROOT = File.expand_path("../", __FILE__)
  end

  RSpec.configure do |config|
  end

  Spork.each_run do
    require 'ski_binding_calculator'
  end
end

