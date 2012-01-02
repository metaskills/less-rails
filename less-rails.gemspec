# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "less/rails/version"

Gem::Specification.new do |s|
  s.name        = "less-rails"
  s.version     = Less::Rails::VERSION
  s.authors     = ["Ken Collins"]
  s.email       = ["ken@metaskills.net"]
  s.homepage    = "http://github.com/metaskills/less-rails"
  s.summary     = %q{The dynamic stylesheet language for the Rails asset pipeline.}
  s.description = %q{The dynamic stylesheet language for the Rails asset pipeline. Allows other gems to extend Less load path.}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'less', '~> 2.0.7'
  s.add_runtime_dependency 'actionpack', '>= 3.1'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'rails',  '~> 3.1'
end
