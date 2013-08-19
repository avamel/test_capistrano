require "bundler/capistrano"

# define the application and Version Control settings
set :application, "test_capistrano"
set :repository,  "https://github.com/avamel/test_capistrano.git"
set :deploy_via, :copy
set :user, "root"
set :deploy_to, "/var/www/test_capistrano"
#set :rvm_type, :root  # Literal ":user"
set :scm, :git
set :default_run_options, {:pty => true}
set :use_sudo, false

# Tell Capistrano the servers it can play with

server "37.139.29.126", :app, :web, :db, :primary => true

# Generate an additional task to fire up the thin clusters
namespace :deploy do
  desc "Start the Thin processes"
  task :start do
    run  <<-CMD
      cd /var/www/apps/current; bundle exec thin start -C config/thin.yml
    CMD
  end

  desc "Stop the Thin processes"
  task :stop do
    run <<-CMD
      cd /var/www/apps/current; bundle exec thin stop -C config/thin.yml
    CMD
  end

  desc "Restart the Thin processes"
  task :restart do
    run <<-CMD
      cd /var/www/apps/current; bundle exec thin restart -C config/thin.yml
    CMD
  end

end

#namespace :rvm do
#  task :trust_rvmrc do
#    run "rvm rvmrc trust #{release_path}"
#  end
#end

# Define all the tasks that need to be running manually after Capistrano is finished.
after "deploy", "deploy:migrate"
#after "deploy:migrate", "rvm:trust_rvmrc"