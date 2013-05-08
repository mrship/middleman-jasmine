require 'jasmine'

class JasmineSprocketsProxy
  class << self
    def jasmine_app
      return @@jasmine_app if defined?(@@jasmine_app)
      Jasmine.load_configuration_from_yaml
      @@jasmine_app = Jasmine::Application.app(Jasmine.config)
    end
  end
  jasmine_app

  def initialize(path="")
    @path = path
    @app  = 
      if setup_for_spec_files?
        sprockets_app
      else
        self.class.jasmine_app
      end
  end

  def call(env)
    env["PATH_INFO"] = "/#{@path}#{env["PATH_INFO"]}" unless serving_spec_via_sprockets?
    @app.call(env)
  end

  private

  def sprockets_app
    return self.class.jasmine_app unless defined?(::Sprockets::Environment)
    @sprockets_app ||= ::Sprockets::Environment.new.tap { |s| s.append_path(Jasmine.config.spec_dir) }
  end

  def setup_for_spec_files?
    @path == "__spec__"
  end

  def serving_spec_via_sprockets?
    setup_for_spec_files? && !!@sprockets_app && @sprockets_app.is_a?(::Sprockets::Environment)
  end
end

# monkey patch Rack::Jasmine::Runner to allow for paths other than /
module Rack
  module Jasmine
    class Runner
      def call(env)
        @path = env["PATH_INFO"]
        [
          200,
          { 'Content-Type' => 'text/html'},
          [@page.render]
        ]
      end      
    end
  end
end