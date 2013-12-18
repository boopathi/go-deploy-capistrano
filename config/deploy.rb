# Required parameters
set :application, "<APPLICATION_NAME>"
set :user, "<USERNAME_ON_SERVER>"

# You might want to modify these too
set :deploy_to, "/home/#{user}/#{appication}"
set :use_sudo, false
set :copy_exclude, [".git","Capfile","*~","*.go","config"]
# Note: The user has to have write permissions to this folder
set :bin_dir, "/home/#{user}/bin"

# Mostly, you need not modify anything
# below this
set :repository, "."
set :scm, :none
set :deploy_via, :copy
set :build_script, "go build -o #{application}"
set :copy_strategy, :export

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

# Some priliminary stuff that needs to be setup
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


