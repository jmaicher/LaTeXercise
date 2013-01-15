Gem::Specification.new do |spec|
  spec.name         = 'LaTeXercise'
  spec.version      = '0.0.1'

  spec.summary      = 'LaTeX exercise sheets on steroids'
  spec.authors      = ['Julian Maicher']
  spec.email        = ['jmaicher@mail.upb.de']

  spec.platform     = Gem::Platform::RUBY
  spec.add_runtime_dependency 'thor', '~> 0.15.4'

  spec.bindir       = 'bin'
  spec.files        = `git ls-files`.split("\n")
  spec.executables  << 'latexercise'
end
