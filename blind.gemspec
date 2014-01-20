Gem::Specification.new do |s|
  s.name        = "blind"
  s.version     = "0.0.1"
  s.summary     = "No view rendering in controller testing."
  s.description = s.summary
  s.authors     = ["Francesco Rodríguez"]
  s.email       = ["frodsan@me.com"]
  s.homepage    = "https://github.com/frodsan/blind"
  s.license     = "Unlicense"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "actionpack"
  s.add_development_dependency "minitest", "~> 4.7"
end
