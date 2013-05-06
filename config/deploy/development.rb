require 'yaml'

server "198.61.235.74", :app, :web, :db, :primary => true
set :deploy_to, "/home/multidevadmin/narddog/"
set :branch, 'master'
set :rails_env, "development"

# server user name
set :user, "multidevadmin"
set :use_sudo, false

# local asset compilation
# before 'deploy:finalize_update', 'deploy:assets:symlink'
# after 'deploy:update_code', 'deploy:assets:precompile'