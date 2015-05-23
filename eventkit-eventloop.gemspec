# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventkit/event_loop'

Gem::Specification.new do |spec|
  spec.name          = "eventkit-eventloop"
  spec.version       = Eventkit::EventLoop::VERSION
  spec.authors       = ["Oliver Martell"]
  spec.email         = ["oliver.martell@gmail.com"]

  spec.summary       = "Event loop for non blocking IO"
  spec.description   =
    "Event loop on top of IO.select for non blocking IO"
  spec.homepage      = "http://github.com/omartell/eventkit-eventloop"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
