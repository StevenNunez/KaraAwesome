# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'GimmeKaraoke/version'

Gem::Specification.new do |spec|
  spec.name          = "GimmeKaraoke"
  spec.version       = GimmeKaraoke::VERSION
  spec.authors       = ["Steven Nunez"]
  spec.email         = ["steven.nunez@gmail.com"]
  spec.summary       = %q{Find Karaoke versions of songs on video sites}
  spec.description   = %q{Find Karaoke versions of songs on video sites}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
end
