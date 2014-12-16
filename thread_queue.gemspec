# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thread_queue/version'

Gem::Specification.new do |spec|
  spec.name          = 'thread_queue'
  spec.version       = ThreadQueue::VERSION
  spec.authors       = ['Jon Palmer', 'Ryan Duryea']
  spec.email         = ['jmpalme4@gmail.com', 'aguynamedryan@gmail.com']
  spec.summary       = %q{An easy to use worker thread queue}
  spec.description   = %q{An easy to use worker thread queue that enables easy parallelization of code block execution.}
  spec.homepage      = 'https://github.com/jmpalmer/thread-queue'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
end
