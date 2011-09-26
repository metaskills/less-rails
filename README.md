# The dynamic stylesheet language for the Rails asset pipeline.

This gem provides integration for Rails projects using the Less stylesheet language in the asset pipeline.


## Installing

Until we can publish this gem under an official less-rails name, please bundle to the git repo.

    gem 'less-rails', :git => 'git://github.com/metaskills/less-rails.git'


## Configuration

This gem was made for other gems to properly hook into one place to provide paths to the Less::Parser. For example, the less-rails-bootstrap project at http://github.com/metaskills/less-rails-bootstrap and each project should do the path configuration for you. If you need to, you can configure less-rails with additional paths. These paths have higher priority than those from your applications assets load paths.

```ruby
MyProject::Application.configure do
  config.less.paths << "#{Rails.root}/lib/less/stylesheets"
end
```

## License

Less::Rails is Copyright (c) 2011 Ken Collins, <ken@metaskills.net> and is distributed under the MIT license.

