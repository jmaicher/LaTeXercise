# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'guard-latexercise'
  s.summary     = 'Guard gem for latexercise'
  s.version     = '0.0.1'
  s.authors     = ['Julian Maicher']
  s.email       = ['mail@jmaicher.de'] 
  
  s.platform    = Gem::Platform::RUBY

  s.add_dependency  'guard', '~> 1.2.3'
  
  s.files         = Dir['{lib}/**/*.rb']
  s.require_path  = 'lib'
end
