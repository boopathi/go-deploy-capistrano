# Required parameters
set :application, "<APPLICATION_NAME>"
set :user, "<USERNAME_ON_SERVER>"

# You might want to modify these too
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false
set :keep_releases, 3
# #{user} should have write permissions to #{bin_dir}
set :bin_dir, "/home/#{user}/bin"

set :stages, %w(production staging)
set :default_stage, "production"

# Set of files to exclude
set :copy_exclude, [".go", "**/*.go",
  # go
  "*.o", "*.a", "*.so",
  # git
  ".gitignore", ".git",
  # *akefiles
  "Makefile*", "Capfile*", "config/*.rb"
]

# VCS settings
set :repository, "."
set :scm, :none

# Copy files to deploy
set :deploy_via, :copy
set :copy_strategy, :export

# Cap deploy copies the files to tmp directory and 
# go build takes the directory's name as the app's name
# So, to override that, we use `-o #{application}`
set :build_script, "go build -o #{application}"

require 'capistrano/ext/multistage'

# Import the servers list
task :staging do
  servers = IO.read("config/staging.list").split
  role(:app) { servers }
end
task :production do
  servers = IO.read("config/production.list").split
  role(:app) { servers }
end

# If the application is running as a service,
# use these hooks to start, stop or restart
namespace :deploy do
  task :migrate do #no-op
  end
  task :finalize_update do #no-op
  end
  task :start do
    #run "#{bin_dir}/#{application} start"
  end
  task :stop do
    #run "#{bin_dir}/#{application} stop"
  end
  task :restart do
    #run "#{bin_dir}/#{application} restart"
  end
end

# Some preliminary stuff that needs to be setup
namespace :remote do
  task :create_apps_dir do
    run "mkdir -p #{deploy_to}/releases"
    run "mkdir -p #{bin_dir}"
  end
  task :symlink_to_bin do
    run "rm -f #{bin_dir}/#{application}"
    run "ln -s #{deploy_to}/current/#{application} #{bin_dir}/#{application}"
  end
end

after "deploy:setup", "remote:create_apps_dir"
after "deploy", "remote:symlink_to_bin"
