set :application, "bon-appetit"
set :repository,  "git://github.com/lperichon/bon-appetit.git"

set :scm, "git"

set :branch, "master"

set :domain, "74.63.8.222"
set :user, "variete"
set :rails_env, :production
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :chmod755, %w(app config db public vendor script tmp public/dispatch.cgi public/dispatch.fcgi public/dispatch.rb)
set :use_sudo, false
default_run_options[:pty] = true

role :web, domain
role :app, domain
role :db,  domain, :primary => true

after "deploy:symlink", "deploy:copy_files"

namespace :deploy do
  task :start do

  end

  task :stop do

  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Set the proper permissions for directories and files on HostingRails accounts"
  task :after_deploy do
    run(chmod755.collect do |item|
      "chmod 755 #{current_path}/#{item}"
    end.join(" && "))
  end

  task :copy_files do
    run "cp -pf #{deploy_to}/to_copy/environment.rb #{current_path}/config/environment.rb"
    run "cp -pf #{deploy_to}/to_copy/database.yml #{current_path}/config/database.yml"
  end
end