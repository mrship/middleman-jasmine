# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/jasmine/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-jasmine"
  spec.version       = Middleman::Jasmine::VERSION
  spec.authors       = ["Andy Shipman"]
  spec.email         = ["andy@cllearview.com"]
  spec.description   = %q{Jasmine testing framework support for Middleman}
  spec.summary       = %q{Integrates Jasmine into a Middleman app. Optional support for Sprockets.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'jasmine', "~> 2.0.0"
  spec.add_dependency 'middleman', '~> 3.3.2'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
