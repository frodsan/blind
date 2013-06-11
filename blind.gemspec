# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = 'blind'
  s.version     = '0.0.1'
  s.summary     = 'No view rendering in controller testing.'
  s.description = 'No view rendering in controller testing.'
  s.authors     = ['Francesco Rodríguez']
  s.email       = ['lrodriguezsanc@gmail.com']
  s.homepage    = 'https://github.com/frodsan/blind'
  s.license     = 'MIT'

  s.files = Dir[
    'LICENSE',
    'README.md',
    'lib/**/*.rb',
    '*.gemspec',
    'test/*.*'
  ]

  s.add_dependency 'activesupport'
  s.add_dependency 'actionpack'
  s.add_development_dependency 'minitest', '4.7.4'
end
