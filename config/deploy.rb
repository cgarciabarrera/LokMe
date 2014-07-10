require "rvm/capistrano"
set :rvm_type, :user
require 'bundler/capistrano'
require './config/deploy_tasks/after_deploy'

set :normalize_asset_timestamps, false
set :repository,  "git@github.com:cgarciabarrera/LokMe.git"
set :user, "web"

set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :keep_releases, 5
set :scm, :git
set :deploy_via, :remote_cache

default_run_options[:pty] = true
#default_run_options[:shell] = '/bin/bash'



begin
  case targetname


    when 'production' then
      # Prompt to make really sure we want to deploy into prouction
      puts "\n\e[0;31m   ######################################################################"
      puts "   #\n   #       Estas seguro de querer hacer un deploy a produccion?"
      puts "   #\n   #               Introduzca y/N + o intro para continuar\n   #"
      puts "   ######################################################################\e[0m\n"
      proceed = STDIN.gets[0..0] rescue nil
      exit unless proceed == 'y' || proceed == 'Y'

      #set :rvm_ruby_string, 'ruby-1.9.2-p180@fundspeople'
      set :application, "www.lokusapp.com"
      set :deploy_to, "/home/web/apps/#{application}"
      role :app, "www.lokusapp.com"
      role :web, "www.lokusapp.com"
      role :db,  "www.lokusapp.com", :primary => true
      set :rails_env, "production"
      set :branch, "production"

      set :bundle_without, [:development]

    else
      raise Capistrano::Error, "Your targetname is invalid, please use [pre|www]"
  end
rescue
  raise Capistrano::Error, "You need to pass -S targetname=[development2 | staging2 | production ]\n\nFor example:\n   cap -S targetname=production deploy"
end



# -- Unicorn stuff
set :unicorn_binary, "bundle exec unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid,    "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

# -- Stuff to do after deploy
after "deploy:update_code", "deploy:symlink_config", "deploy:cleanup"#, "ts:arrancar"
after "deploy:setup","deploy:create_dirs"