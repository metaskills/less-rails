CHANGELOG
=========

2.1.0 - 11/18/2011
------------------
* Remove our basic CssCompressor since it can not handle real world general purpose JS
  compression. Instead set parse compression and recommend final YUI Compressor. Fixes #7.
* Import preprocessor so @import'ed less files are automatic asset dependencies. Fixes #3.


2.0.3 - 11/13/2011
------------------
* Add generator support. Fixes #8.
* Add a Less::Rails::CssCompressor if config.assets.compress is true. Fixes #7.


2.0.2 - 10/09/2011
------------------
* Extend LESS with Rails asset pipeline helpers.
* New testing support with MiniTest::Spec and dummy Rails::Application.
* New config.options hash passed down to the #to_css method.


2.0.1 - 09/28/2011
------------------

* Fix require of less/rails/railtie.rb. Thanks Benoit Bénézech (bbenezech).


2.0.0 - 09/25/2011
------------------

* Initial 2.0 release. Heavily inspired/copied code from sass-rails.


1.0.0 - 02/02/2010
------------------

* Original project at http://github.com/yeastymobs/less-rails
