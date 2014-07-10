#! /usr/bin/env ruby

#listen "/tmp/.freeditorial_com_unicorn.sock"
listen "/tmp/.lokusapp_production_com_unicorn.sock"

worker_processes 4

APP_PATH = "/home/web/apps/"

if ENV['RAILS_ENV'] == 'staging'
  timeOut = 200
  Dir = "lokme.lextrendlabs.com/"
else
  timeOut = 4000
  Dir = "www.lokusapp.com/"
end

working_directory APP_PATH + Dir + "current/"
timeout timeOut
pid APP_PATH + Dir + "current/tmp/pids/unicorn.pid"
stderr_path APP_PATH + Dir + "current/log/lokme.stderr.log"
stdout_path APP_PATH + Dir + "current/log/lokme.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
