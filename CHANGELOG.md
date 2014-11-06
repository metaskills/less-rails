# CHANGELOG

### 2.6.0 - 2014-11-07

* Update to Less.rb v2.6.
* Merge PR #88 'Fix dropped import dependencies'.

### 2.5.0 - 2014-03-11

* Update to Less.rb v2.5 and follow version mirror. Fixes #84.


### 2.4.2 - 2013-09-07

* Another stab at better initialization process. Fixes #68. Fixes #62.
  NOTE: If you were using `less-rails.after.load_config_initializers`, please
  change your initializer to use `less-rails.before.load_config_initializers`.

### 2.4.1 - 2013-09-07

* Fix import hooks to allow relative paths to files. Fixes #72 and #64.
* Use config.(before|after)_initialize for better railtie pattern. Fixed #68.

### 2.4.0 - 2013-09-04

* Moving to less.rb 2.4.x which is current v### 1.4.2 of less.

### 2.3.3 - 2013-04-16

* Implement dumpLineNumbers functionality. Thanks @matthew342.

### 2.3.2 - 2013-03-06

* Rails 4 compatability. Thanks @zhengjia.

### 2.3.1 - 2013-03-06

* Update to less gem ### 2.3.1 which really uses less v### 1.3.3

### 2.3.0 - 2013-03-06

* Update to less gem ### 2.3.0 thanks @leifcr

### 2.2.6 - 2012-10-31

* Accidental release. Nothing new.

### 2.2.5 - 2012-10-28

* Real Rails 4 compatability thanks to @yalab

### 2.2.4 - 2012-10-20

* Rails 4 compatability with Sprockets vs app.assets.

### 2.2.3 - 2012-05-27

* Add default_mime_type to template class since it does not inherit from Tilt's.
  Should fix https://github.com/metaskills/less-rails/issues/35

### 2.2.2 - 2012-04-25

* Remove explicit dependency on therubyracer
* Add jruby and jruby --1.9 to travis configuration
* Officially support JRuby

### 2.2.1 - 2012-04-15

* Make it usable with therubyrhino (and older versions of therubyracer as well). Fixes #36.

### 2.2.0 - 2012-03-29

* Upgrade to therubyracer 0.10.x call semantics. Fixes #34.

### 2.1.8 - 2012-03-15

* Work with edge rails/sprockets. Fixes #31.

### 2.1.7 - 2012-03-07

* More defensive railtie when examing asset paths. Fixes #30.

### 2.1.6 - 2012-02-16

* Nested imports recursively declare sprockets dependencies. Fixes #26.

### 2.1.4, ### 2.1.5 - 2012-01-31

* More friendly import processor with missing files. Fixes #13.

### 2.1.3 - 2012-01-23

* Make sure vendor/assets/stylesheets .less files work.

### 2.1.2 - 2011-12-20

* No notes.

### 2.1.1 - 2011-11-24

* All app asset stylesheet paths are added to less paths.

### 2.1.0 - 2011-11-18

* Remove our basic CssCompressor since it can not handle real world general purpose JS
  compression. Instead set parse compression and recommend final YUI Compressor. Fixes #7.
* Import preprocessor so @import'ed less files are automatic asset dependencies. Fixes #3.

### 2.0.3 - 2011-11-13

* Add generator support. Fixes #8.
* Add a Less::Rails::CssCompressor if config.assets.compress is true. Fixes #7.

### 2.0.2 - 2011-10-09

* Extend LESS with Rails asset pipeline helpers.
* New testing support with MiniTest::Spec and dummy Rails::Application.
* New config.options hash passed down to the #to_css method.

### 2.0.1 - 2011-09-28

* Fix require of less/rails/railtie.rb. Thanks Benoit Bénézech (bbenezech).

### 2.0.0 - 2011-09-25

* Initial 2.0 release. Heavily inspired/copied code from sass-rails.

### 1.0.0 - 2010-02-02

* Original project at http://github.com/yeastymobs/less-rails
