Capistrano::Configuration.instance(:must_exist).load do

  files = %w(
    database.yml
    environments/development.rb
    environments/staging.rb
    environments/production.rb
  )

  dirs = %w(
    config
  )


  namespace :deploy do
    task :symlink_config, :roles => :app do
      files.each do |f|
        run "ln -nfs #{shared_path}/config/#{f} #{release_path}/config/#{f}"
      end
      run "ln -nfs #{shared_path}/.rvmrc #{release_path}/.rvmrc"
#      if rvm == 1
#        run "ln -nfs #{shared_path}/config/.rvmrc #{release_path}/.rvmrc"
#        run "cd #{release_path}"
#      #  run "rvm reload"
#      end
    end

    task :create_dirs, :roles => :app do

      dirs.each do |d|
        run "mkdir -p #{shared_path}/#{d}"
      end

      run "chown -R #{user} #{deploy_to}"
      run "mkdir -p #{deploy_to}/releases"
      run "chown -R #{user} #{deploy_to}/releases"

    end

    desc "Enables maintenance mode in the app"
    task :maintenance_on, :roles => :app do
      run "cp #{shared_path}/system/maintenance.html.disabled #{release_path}/public/system/maintenance.html"
    end

    desc "Disables maintenance mode in the app"
    task :maintenance_off, :roles => :app do
      run "rm #{shared_path}/system/maintenance.html"
    end

    desc "Populates the Production Database"
    task :seed , :roles => :db, :only => {:primary => true} do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake db:seed"
    end

    task :createDB , :roles=> :app do
      run "cd #{current_path} && rake db:create RAILS_ENV=#{rails_env}"
    end

    task :migrateDB , :roles=> :app do
      run "cd #{current_path} && rake db:migrate RAILS_ENV=#{rails_env}"
    end

    task :friendlyURL, :roles=> :app do
      run "cd #{current_path} && rake friendly RAILS_ENV=#{rails_env}"
    end

  end

end
