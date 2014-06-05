# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dummy-apartment'

Gem::Specification.new do |spec|
  spec.name          = "dummy-apartment"
  spec.version       = DummyApartment::VERSION
  spec.authors       = ["Joe-noh"]
  spec.email         = ["goflb.jh@gmail.com"]
  spec.summary       = %q{Generator of Japanese Apartment Dummy Data}
  spec.description   = %q{This gem generates dummy information of apartment, including address, name, room number, geo and more.}
  spec.homepage      = "https://github.com/Joe-noh/dummy-apartment"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
