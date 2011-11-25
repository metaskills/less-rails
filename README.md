# The dynamic stylesheet language for the Rails asset pipeline.

This gem provides integration for Rails projects using the Less stylesheet language in the asset pipeline.



## Installing

Just bundle up less-rails in your Gemfile. This will pull in less as a runtime dependency too.

    gem 'less-rails'



## Configuration

This gem was made for other gems to properly hook into one place to provide paths to the Less::Parser. For example, the less-rails-bootstrap project at http://github.com/metaskills/less-rails-bootstrap and each project should do the path configuration for you. If you need to, you can configure less-rails with additional paths. These paths have higher priority than those from your applications assets load paths.

```ruby
MyProject::Application.configure do
  config.less.paths << "#{Rails.root}/lib/less/protractor/stylesheets"
  config.less.compress = true
end
```

#### About Compression

If `config.assets.compress` is set to true, we will set the `config.less.compress` to true as well. Less has real basic compression and it is recommended that you set the rails `config.assets.css_compressor` to something more stronger like `:yui` in your `config/environments/production.rb` file. Note, this requires the [yui-compressor](https://rubygems.org/gems/yui-compressor) gem but does an excellent job of compressing assets.



## Import Hooks

Any `@import` to a `.less` file will automatically declare that file as a sprockets dependency to the file importing it. This means that you can edit imported framework files and see changes reflected in the parent durning development. So this:

```css
@import "frameworks/bootstrap/mixins";

#leftnav { .border-radius(5px); }
```

Will end up acting as if you had done this below:

```css
/*
 *= depend_on "frameworks/bootstrap/mixins.less"
*/

@import "frameworks/bootstrap/mixins";

#leftnav { .border-radius(5px); }
```



## Helpers

When referencing assets use the following helpers in LESS.

```css
asset-path(@relative-asset-path)  /* Returns a string to the asset. */
asset-path("rails.png")           /* Becomes: "/assets/rails.png" */

asset-url(@relative-asset-path)   /* Returns url reference to the asset. */
asset-url("rails.png")            /* Becomes: url(/assets/rails.png) */
```

As a convenience, for each of the following asset classes there are corresponding `-path` and `-url` helpers image, font, video, audio, javascript and stylesheet. The following examples only show the `-url` variants since you get the idea of the `-path` ones above.

```css
image-url("rails.png")            /* Becomes: url(/assets/rails.png) */
font-url("rails.ttf")             /* Becomes: url(/assets/rails.ttf) */
video-url("rails.ttf")            /* Becomes: url(/videos/rails.mp4) */
audio-url("rails.ttf")            /* Becomes: url(/audios/rails.mp3) */
javascript-url("rails.js")        /* Becomes: url(/assets/rails.js) */
stylesheet-url("rails.css")       /* Becomes: url(/assets/rails.css) */
```

Lastly, we provide a data url method for base64 encoding assets.

```css
asset-data-url("rails.png")       /* Becomes: url(data:image/png;base64,iVBORw0K...) */
```

Please note that these helpers are only available server-side, and something like ERB templates should be used if client-side rendering is desired.



## Generators

Installation of the gem will set your applications stylesheet engine to use Less. It is possible to have many gems that set the stylesheet engine, for instance the sass-rails and/or stylus gems. In this case, you can resolve the ambiguity by setting the stylesheet engine in your `config/application.rb` file like so. Doing so would mean all generated assets will be in the a fresh `css.less` template.

```ruby
config.app_generators.stylesheet_engine :less
```

We have generators for both assets and scaffold in the `less` namespace. For instance the following would generate a blank `app/assets/stylesheets/posts.css.less` template.

```
$ rails generate less:assets posts
```

We also have a generator for rails scaffold CSS. Just like the Sass gem, we simply parse the scaffold.css in the default rails generator and save it as a scaffolds.css.less file. This is done automatically during other scaffold generator actions.



## Testing

Simple! Just clone the repo, then run `bundle install` and `bundle exec rake`. The tests will begin to run. We also use Travis CI to run our tests too. Current build status is:

[![Build Status](https://secure.travis-ci.org/metaskills/less-rails.png)](http://travis-ci.org/metaskills/less-rails)



## License

Less::Rails is Copyright (c) 2011 Ken Collins, <ken@metaskills.net> and is distributed under the MIT license.

