# The dynamic stylesheet language for the Rails asset pipeline.

This gem provides integration for Rails projects using the Less stylesheet language in the asset pipeline.


## Installing

Just bundle up less-rails in your Gemfile. This will pull in less as a runtime dependency too.

    gem 'less-rails'


## Configuration

This gem was made for other gems to properly hook into one place to provide paths to the Less::Parser. For example, the less-rails-bootstrap project at http://github.com/metaskills/less-rails-bootstrap and each project should do the path configuration for you. If you need to, you can configure less-rails with additional paths. These paths have higher priority than those from your applications assets load paths.

```ruby
MyProject::Application.configure do
  config.less.paths << "#{Rails.root}/lib/less/stylesheets"
  config.less.compress = true
end
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


## License

Less::Rails is Copyright (c) 2011 Ken Collins, <ken@metaskills.net> and is distributed under the MIT license.

