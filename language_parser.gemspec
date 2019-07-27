# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "language_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "language_parser"
  spec.version       = LanguageParser::VERSION
  spec.authors       = ["Jean Aguilar"]
  spec.email         = ["jean-marco-10@hotmail.com"]

  spec.summary       = "Basic parser for c#."
  spec.homepage      = "https://github.com/jean182/c-sharp-parser"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb", "lib/**/**/*.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rspec", "~> 3.8"
end
