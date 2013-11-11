# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pux_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "pux_sdk"
  spec.version       = PuxSDK::VERSION
  spec.authors       = ["Akiho Kurino", "Daniel Perez"]
  spec.email         = ["ak030402@gmail.com", "tuvistavie@gmail.com"]
  spec.description   = "SDK for PUX api"
  spec.summary       = "SDK for PUX api"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  spec.add_dependency "httpclient"
  spec.add_dependency "crack"
end
