require 'capistrano/ext/multistage'
require 'rvm/capistrano'
require 'whenever/capistrano'
# require "delayed/recipes"

set :application, "NardDog"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# git stuff
set :scm, :git
set :repository,  "git@bitbucket.org:nfranken/nard-dog.git"
# set :scm_passphrase, "" # 2iRf7xqZkjJteK

# stages
set :stages, ["development", "production"]
set :default_stage, "development"

# keep only the last 5 releases
after "deploy", "deploy:cleanup"


# ==============================
# Uploads / database.yml
# ==============================

namespace :uploads do

  desc "Creates the upload folders unless they exist and sets the proper upload permissions."
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "touch #{shared_path}/config/database.yml"

    # copy existing uploaded media to new shared folder
    run "cp -r /home/multidevadmin/narddog/current/public/system /home/multidevadmin/narddog/shared/uploads"
  end

  desc "[internal] Creates the symlink to uploads shared folder for the most recently deployed version."
  task :symlink, :except => { :no_release => true } do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm -rf #{release_path}/public/system"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/system"

    run "rm -rf #{release_path}/public/inputs"
    run "ln -nfs #{shared_path}/uploads/inputs #{release_path}/public/inputs"

    run "ln -nfs #{shared_path}/config/database.yml"
  end

  desc "[internal] Computes uploads directory paths and registers them in Capistrano environment.
    Note. I can't set value for directories directly in the code because
    I don't know in advance selected stage."
  task :register_dirs do
    set :uploads_dirs,    %w(uploads config).map { |d| "#{stage}/#{d}" }
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink"#, "deploy:database_yml"
  on :start,  "uploads:register_dirs",  :except => stages + ['multistage:prepare']

end

namespace :deploy do
        desc "restart the rails app"
        task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
        end

  desc "bundle and migrate"
  task :bundle_and_migrate, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle"
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:migrate"
  end

  namespace :assets do

    task :precompile, :roles => :web do
      begin
        from = source.next_revision(current_revision)
      rescue
        err_no = true
      end
      from = source.next_revision(current_revision)
      if err_no || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        run_locally("rake assets:clean && rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    task :symlink, roles: :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end

  # delayed job
  # after "deploy:stop",    "delayed_job:stop"
  # after "deploy:start",   "delayed_job:start"
  # after "deploy:restart", "delayed_job:restart"
  before 'deploy:restart', 'deploy:bundle_and_migrate'

end