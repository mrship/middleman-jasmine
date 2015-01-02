require 'middleman/rack'

require 'json'
require 'jasmine'
require 'jasmine/config'

namespace :middleman_jasmine do
  desc 'Run Jasmine-tests with PhantomJS and print result. Exit with code 1 or 0.'

  task :ci do
    config       = Jasmine.config
    logger       = Logger.new($stdout)
    logger.level = Logger::WARN
    server       = Rack::Server.new(:app => Middleman.server, :Port => config.port(:ci), :AccessLog => [], :Logger => logger)

    t = Thread.new do
      begin
        server.start
      rescue ChildProcess::TimeoutError
      end
      # # ignore bad exits
    end
    t.abort_on_exception = true
    Jasmine::wait_for_listener(config.port(:ci), 'jasmine server')
    puts 'jasmine server started.'

    formatters = config.formatters.map { |formatter_class| formatter_class.new }

    exit_code_formatter = Jasmine::Formatters::ExitCode.new
    formatters << exit_code_formatter

    middleman_extensions = ::Middleman::Application.server.inst.extensions
    throw "Middleman Jasmine extension not activated" unless middleman_extensions.has_key?(:jasmine)

    path   = middleman_extensions[:jasmine].jasmine_url
    url    = "#{config.host}:#{config.port(:ci)}#{path}"
    runner = config.runner.call(Jasmine::Formatters::Multi.new(formatters), url)
    if runner.respond_to?(:boot_js)
      config.runner_boot_dir = File.dirname(runner.boot_js)
      config.runner_boot_files = lambda { [runner.boot_js] }
    end
    runner.run

    abort unless exit_code_formatter.succeeded?
  end
end
