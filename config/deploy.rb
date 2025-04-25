# Capistrano version
lock "~> 3.19.2"

set :application, "BoxNet"
set :repo_url, "git@github.com:michaele490/BoxNet.git"
set :deploy_to, "/home/ubuntu/BoxNet"
# May have to change deploy_to path depending on what's used in the instance


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


append :linked_files, "config/database.yml", "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# How many deployments capistrano can roll back to
set :keep_releases, 5
set :keep_assets, 5

namespace :deploy do
    desc "Restart application"
    task :restart do
        on roles(:app), in: :sequence, wait: 5 do
            execute :touch, release_path.join("tmp/restart.txt")
        end
    end

    after :publishing, "deploy:restart"
    after :finishing, "deploy:cleanup"
end
