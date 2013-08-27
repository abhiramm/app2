require "bundler/capistrano"
load 'deploy/assets'

set :bundle_flags, "--deployment --quiet --binstubs"


server "192.241.252.5", :web, :app, :db, primary: true

set :application, "custom"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :repository_cache, "cached_copy"
set :scm, "git"
set :repository, "git@bitbucket.org:vysakh0/custom.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

#set :sidekiq_role, :sidekiq
#role :sidekiq, "192.241.129.33"
#set :sidekiq_processes, 1


set :default_environment, {
    'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}
namespace :deploy do
    %w[start stop restart].each do |command|
        desc "#{command} unicorn server"
        task command, roles: :app, except: {no_release: true} do
            run "/etc/init.d/unicorn_#{application} #{command}"
        end
    end

    task :setup_config, roles: :app do
        sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
        sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
        run "mkdir -p #{shared_path}/config"
        put File.read("config/database.sample.yml"), "#{shared_path}/config/database.yml"
        puts "Now edit the config files in #{shared_path}."
    end
    after "deploy:setup", "deploy:setup_config"

    task :symlink_config, roles: :app do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
    after "deploy:finalize_update", "deploy:symlink_config"

		desc "Make sure local git is in sync with remote."
		task :check_revision, roles: :web do
				unless `git rev-parse HEAD` == `git rev-parse origin/master`
						puts "WARNING: HEAD is not the same as origin/master"
						puts "Run `git push` to sync changes."
						exit
				end
		end
		before "deploy", "deploy:check_revision"
end

namespace :db do
    desc "Destroys Production Database"
    task :drop do
        puts "\n\n=== Destroying the Production Database! ===\n\n"
        run "cd #{current_path}; rake db:drop RAILS_ENV=production"
    end
end
