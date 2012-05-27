CHANGELOG
=========

2.2.3 - 05/27/2012

* Add default_mime_type to template class since it does not inherit from Tilt's.
  Should fix https://github.com/metaskills/less-rails/issues/35

2.2.2 - 04/25/2012

* Remove explicit dependency on therubyracer
* Add jruby and jruby --1.9 to travis configuration
* Officially support JRuby


2.2.1 - 04/15/2012

* Make it usable with therubyrhino (and older versions of therubyracer as well). Fixes #36.


2.2.0 - 03/29/2012

* Upgrade to therubyracer 0.10.x call semantics. Fixes #34.


2.1.8 - 03/15/2012

* Work with edge rails/sprockets. Fixes #31.


2.1.7 - 03/07/2012

* More defensive railtie when examing asset paths. Fixes #30.


2.1.6 - 02/16/2012

* Nested imports recursively declare sprockets dependencies. Fixes #26.


2.1.4, 2.1.5 - 01/31/2012

* More friendly import processor with missing files. Fixes #13.


2.1.3 - 01/23/2012

* Make sure vendor/assets/stylesheets .less files work.


2.1.2 - 12/20/2011

* No notes.


2.1.1 - 11/24/2011
------------------

* All app asset stylesheet paths are added to less paths.


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
