require 'middleman-core'
require 'middleman/jasmine/jasmine_sprockets_proxy'

module Middleman
  module Jasmine
    class << self
      def registered(app, options_hash={}, &block)
        options = OpenStruct.new(default_options.merge(options_hash))

        yield options if block_given?

        app.map(options.jasmine_url) { run ::JasmineSprocketsProxy.new }
        jasmine_asset_folders.each do |item|
          app.map("/#{item}") { run ::JasmineSprocketsProxy.new(item) }
        end
      end

      private

      def jasmine_asset_folders
        %w(__jasmine__ __boot__ __spec__)
      end

      def default_options
        {
          jasmine_url: "/jasmine"
        }        
      end      
    alias :included :registered
    end
  end
end