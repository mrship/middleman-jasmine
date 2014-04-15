# Middleman::Jasmine

This gem adds the Jasmine runner into a middleman app under the `/jasmine` path.
It has (optional) support for Sprockets.

It uses Jasmine 2.0. For Jasmine 1.3 support use the [jasmine_1_3](https://github.com/mrship/middleman-jasmine/tree/jasmine_1_3) branch.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-jasmine'

And then execute:

    $ bundle

## Usage

First run `bundle exec jasmine init` to setup Jasmine.

Then, if you have Sprockets installed through [middleman-sprockets](https://github.com/middleman/middleman-sprockets), you can create a `spec.js` file in `spec/javascripts/` to include all your specs, i.e.

```
//= require application
//= require_tree .
```

Add the following code to your `config.rb` file:

```ruby
activate :jasmine
```

Write a spec file under `spec/javascripts/` and hit `/jasmine` under your Middleman app, e.g. `http://localhost:4567/jasmine`.

You should see the results of the spec pass/fail under Jasmine.


## Rake
You can also run the Jasmine-tests using PhantomJS with Rake:

Add the following to the `Rakefile` generated from `bundle exec jasmine init`:

```ruby
require 'middleman'
require 'middleman-jasmine'
require 'middleman/jasmine/tasks'
```

Then use:

```
rake middleman_jasmine:ci
```

## Configuration

To configure the extension, use:

```ruby
activate :jasmine do |options|
  options.fixtures_dir = "spec/javascripts/fixtures"
  options.jasmine_url  = "/jasmine"
  options.config_file  = "spec/config.yml"
  options.debug_assets = false
end
```

NOTE: `debug_assets` can be used to extract any assets included in the spec files and serve them with `?body=t` to avoid Sprockets compiling them every time a spec re-runs.

## Caveats

If you add additional paths to Sprockets with `append_path` in your `after_configuration` block then you'll most likely need to append the same paths to the `Middleman::Jasmine` Sprockets instance. To do that use the helper `jasmine_sprockets`, i.e.:

```ruby
after_configuration do
  handlebars_path = File.expand_path('../', ::Handlebars::Source.bundled_path)
  sprockets.append_path(handlebars_path)

  # add Handlebars to Jasmine too
  jasmine_sprockets.append_path(handlebars_path)
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
