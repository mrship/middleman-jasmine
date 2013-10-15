require 'middleman-core'
require 'middleman/jasmine/jasmine_sprockets_proxy'

module Middleman
  module Jasmine
    class << self
      def registered(app, options_hash={}, &block)
        app.send :include, InstanceMethods

        options = OpenStruct.new(default_options.merge(options_hash))

        yield options if block_given?

        app.map(options.jasmine_url) { run ::JasmineSprocketsProxy.new }
        jasmine_asset_folders.each do |item|
          app.map("/#{item}") { run ::JasmineSprocketsProxy.new(item) }
        end

        app.map("/#{options.fixtures_dir}") { run Rack::Directory.new(options.fixtures_dir) }

        app.after_configuration do
          ::JasmineSprocketsProxy.configure(sprockets)
        end
      end

      private

      def jasmine_asset_folders
        [
          "__jasmine__", "__boot__", "__spec__"
        ]
      end

      def default_options
        {
          jasmine_url: "/jasmine",
          fixtures_dir: "spec/javascripts/fixtures"
        }        
      end      
    alias :included :registered
    end

    module InstanceMethods
      def jasmine_sprockets
        ::JasmineSprocketsProxy.sprockets_app
      end
    end
  end
end