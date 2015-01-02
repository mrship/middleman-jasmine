require 'middleman-core'
require 'middleman/jasmine/jasmine_sprockets_proxy'

module Middleman
  class JasmineExtension < Extension
    option :jasmine_url,  "/jasmine"
    option :fixtures_dir, "spec/javascripts/fixtures"
    option :config_file,  nil
    option :debug_assets, false

    attr_reader :jasmine_url
    def initialize(app, options_hash={}, &block)
      super
      _o = options

      app.map(_o.jasmine_url) { run ::JasmineSprocketsProxy.new }
      jasmine_asset_folders.each do |item|
        app.map("/#{item}") { run ::JasmineSprocketsProxy.new(item) }
      end

      app.map("/#{_o.fixtures_dir}") { run Rack::Directory.new(_o.fixtures_dir) }

      app.after_configuration do
        ::JasmineSprocketsProxy.configure(sprockets, _o.config_file, _o.debug_assets)
      end
      @jasmine_url = _o.jasmine_url
    end

    helpers do
      def jasmine_sprockets
        ::JasmineSprocketsProxy.sprockets_app
      end
    end

    private

    def jasmine_asset_folders
      [
        "__jasmine__", "__boot__", "__spec__", "__runner_boot__"
      ]
    end
  end
end
