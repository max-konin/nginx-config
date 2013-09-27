# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nginx/config/version'

Gem::Specification.new do |spec|
  spec.name          = "nginx-config"
  spec.version       = Nginx::Config::VERSION
  spec.authors       = ["max-konin"]
  spec.email         = ["mk@kernel-corp.com"]
  spec.description   = %q{Generate unicorn vhost for nginx}
  spec.summary       = %q{Generate unicorn vhost for nginx}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard", "~> 0.7.5"
  spec.add_development_dependency "rails", ">= 3.2.0"

end
