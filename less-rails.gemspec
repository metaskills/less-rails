# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "less/rails/version"

Gem::Specification.new do |gem|
  gem.name        = "less-rails"
  gem.version     = Less::Rails::VERSION
  gem.authors     = ["Ken Collins"]
  gem.email       = ["ken@metaskills.net"]
  gem.homepage    = "http://github.com/metaskills/less-rails"
  gem.summary     = %q{The dynamic stylesheet language for the Rails asset pipeline.}
  gem.description = %q{The dynamic stylesheet language for the Rails asset pipeline. Allows other gems to extend Less load path.}
  gem.license     = 'MIT'
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency 'less', '~> 2.6.0'
  gem.add_runtime_dependency 'actionpack', '>= 5.0'
  gem.add_runtime_dependency 'sprockets', '~> 3.0'
  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'minitest', '5.11.3'
  gem.add_development_dependency 'rails'
end
