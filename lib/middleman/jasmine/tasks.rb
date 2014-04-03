require 'middleman/rack'

require 'json'
require 'jasmine'
require 'jasmine/config'

namespace :jasmine do

  desc 'Run continuous integration tests'
  task :ci do
    config = Jasmine.config

    server = Jasmine::Server.new(config.port(:ci), Middleman.server)
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

    # FIXME: hardcoded path. should use options sent to Middleman::Jasmine.registered instead
    path = "/jasmine"
    url = "#{config.host}:#{config.port(:ci)}#{path}"
    runner = config.runner.call(Jasmine::Formatters::Multi.new(formatters), url)
    runner.run

    break unless exit_code_formatter.succeeded?
  end

end

