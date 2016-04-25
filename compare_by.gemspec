# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compare_by/version'

Gem::Specification.new do |spec|
  spec.name          = "compare_by"
  spec.version       = CompareBy::VERSION
  spec.authors       = ["Aidan Feldman"]
  spec.email         = ["aidan.feldman@gmail.com"]

  spec.summary       = %q{A better version of Ruby's Comparable.}
  spec.homepage      = "https://github.com/afeld/compare_by"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
