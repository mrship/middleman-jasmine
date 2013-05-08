# Middleman::Jasmine

This gem adds the Jasmine runner into a middleman app under the /jasmine path. 
It has (optional) support for sprockets.

## Installation

Add this line to your application's Gemfile:

    gem 'middleman-jasmine'

And then execute:

    $ bundle

## Usage

First run `bundle exec jasmine init` to setup Jasmine.

Then, if you have sprockets installed through [middleman-sprockets](https://github.com/middleman/middleman-sprockets), you can create a spec.js file in spec/javascripts to include all your specs, i.e.
```
  //= require_tree .
```

Add the following code to your `config.rb` file:
```
  activate: :jasmine
```

Write a spec file under spec/javascripts and hit /jasmine under your Middleman app, e.g. http://localhost:4567/jasmine.

You should see the results of the spec pass/fail under Jasmine. 

NOTE: If you want to include your application.js into the test suite, it is best to do that under jasmine.yml, i.e:
```yaml
src_files:
  - source/app/javascripts/application.js
```
That is because the Sprockets instance that compiles the specs uses spec/javascripts as its path to load the js. This causes issues with loading the application via a `//= require application` line.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
