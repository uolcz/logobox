# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logobox/version'

Gem::Specification.new do |spec|
  spec.name          = "logobox"
  spec.version       = Logobox::VERSION
  spec.authors       = ["Dmitry Silchenko"]
  spec.email         = ["silchenko@uol.cz"]
  spec.summary       = %q{Simple library for generating URL for logos from logobox.cz}
  spec.description   = %q{Simple library for generating URL for logos from logobox.cz}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end



