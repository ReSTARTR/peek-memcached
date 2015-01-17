# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peek-memcached/version'

Gem::Specification.new do |spec|
  spec.name          = "peek-memcached"
  spec.version       = Peek::Memcached::VERSION
  spec.authors       = ["Masaki YOSHIDA"]
  spec.email         = ["yoshida@vasily.jp"]
  spec.summary       = %q{Take a peek into the Memcached calls made within your Rails application.}
  spec.description   = %q{Take a peek into the Memcached calls made within your Rails application.}
  spec.homepage      = "http://github.com/ReSTARTR/peek-memcached"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "peek"
  spec.add_dependency "memcached"
  spec.add_dependency "atomic", '>= 1.0.0'
end
