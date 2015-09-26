# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'valid_credit_card/version'

Gem::Specification.new do |spec|
  spec.name          = "valid_credit_card"
  spec.version       = ValidCreditCard::VERSION
  spec.authors       = ["Pablo Moreira Mora"]
  spec.email         = ["pablo.moreiramora@gmail.com"]

  spec.summary       = %q{ActiveModel validation for credit card number.}
  spec.description   = %q{ActiveModel validation for credit card number.}
  spec.homepage      = "https://github.com/pablodv/valid_credit_card"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "activemodel", ">= 3.2"
end
