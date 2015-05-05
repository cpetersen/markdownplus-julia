# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdownplus/julia/version'

Gem::Specification.new do |spec|
  spec.name          = "markdownplus-julia"
  spec.version       = Markdownplus::Julia::VERSION
  spec.authors       = ["Christopher Petersen"]
  spec.email         = ["chris@petersen.io"]
  spec.description   = %q{Julia plugin for Markdownplus}
  spec.summary       = %q{Adds the ability to execute arbitrary Julia code and bring the results back into Markdownplus}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "markdownplus"
end
