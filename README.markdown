# The dynamic stylesheet language for the Rails asset pipeline.

This gem provides integration for Rails projects using the Less stylesheet language in the asset pipeline.


## Installing

Until we can publish this gem under an official less-rails name, please bundle to the git repo.

    gem 'less-rails', :git => 'git://github.com/metaskills/less-rails.git'


## Configuration

This gem was made for other gems to properly hook into one place to provide paths to the Less::Parser. For example, the twitter-bootstrap-rails project at http://github.com/seyhunak/twitter-bootstrap-rails


### Example

At the moment, the twitter-bootstrap-rails project does not yet allow the asset pipeline to use the bootstrap .less files. So here is an example of how to configure your application to push that directory to the Less::Rails load_paths.

```ruby
MyProject::Application.configure do
  config.less.load_paths << "#{Gem.loaded_specs['twitter-bootstrap-rails'].full_gem_path}/vendor/assets/stylesheets/bootstrap"
end
```

Then in your foo.css.less file you can do this.

```css
@import "bootstrap";

#foo {
  .border-radius(4px);
}
```


## License

Less::Rails is Copyright (c) 2011 Ken Collins, <ken@metaskills.net> and is distributed under the MIT license.

