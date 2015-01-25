0.5.1
===
* Fix `rake middleman_jasmine:ci` by adding runner_boot dir. [clemenshelm]

0.5.0
===
* Upgrade from Jasmine 1.3 to Jasmine 2.0. [johanlunds]
* Add Rake-task that runs the tests with PhantomJS. Use `rake middleman_jasmine:ci` [johanlunds, mrship]
* Update to new Middleman extension format [mrship]

0.4.0
===
* Add debug_assets option to expand the assets into individual files. Defaults to false.

0.3.0
===
* Add config_file option for specifying jasmine config file [byteio, mrship]

0.2.0
===
* Revise so fixtures are served by Rack::Directory

0.1.1
===
Rename lib/middleman/jasmine.rb to lib/middleman-jasmine.rb per the middleman extension convention.

0.1.0
===

* Configure in #after_configuration block
* Apply all middleman_sprockets paths to our internal sprockets
* Expose internal sprockets app with jasmine_sprockets helper

0.0.3
===

* Only use one Sprockets instance
* Support for fixtures loading from a :fixtures_dir option
* Fix for not using Sprockets

0.0.2
===
Yanked

0.0.1
===

* Initial support for Jasmime
