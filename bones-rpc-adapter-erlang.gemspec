# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bones/rpc/adapter/erlang/version'

Gem::Specification.new do |spec|
  spec.name          = "bones-rpc-adapter-erlang"
  spec.version       = Bones::RPC::Adapter::Erlang::VERSION
  spec.authors       = ["Andrew Bennett"]
  spec.email         = ["andrew@pagodabox.com"]
  spec.description   = %q{Bones::RPC erlang adapter for ruby}
  spec.summary       = %q{Bones::RPC erlang adapter for ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bones-rpc"
  spec.add_dependency "erlang-etf"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
