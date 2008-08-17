require 'etc'
# Load the mongrel_cluster tasks
require 'mongrel_cluster/recipes'

# You must set :application, :repository, and :server in your Capfile

# Sets the RAILS_ENV for this deployment. Default: staging
set(:rails_env, ENV["RAILS_ENV"] ? ENV["RAILS_ENV"].to_sym : :staging)

# Sets the environment for the mongrel cluster
set(:mongrel_environment) { rails_env }

if branch = ENV["BRANCH"]
  set(:branch, branch)
end

set(:deploy_via, :remote_cache)

# Sets the server. This MUST be set.
# set(:server) { abort "Please specify the server to deploy to, set :server, 'example.com'" }
# role(:web)                  { server }
# role(:app)                  { server }
# role(:db, :primary => true) { server }

# Sets the user to deploy as. Default: #{application}
set(:user) { application }

# Sets the user to run mongrel processes as
set(:mongrel_user) { application }

# Sets the group to run mongrel processes as
set(:mongrel_group) { application }

set :scm, :git

# Sets the location to deploy to. Default: /var/www/#{application}/#{rails_env}
set(:deploy_to) { "/var/www/#{application}/#{rails_env}" }

# Sets the extra paths to symlink.
set(:symlinks, [])

set(:backups, [])
set(:backup_on_deploy, true)

set(:use_sudo, false)

# Sets the mongrel_cluster config location. Default: #{shared_path}/config/mongrel_cluster.yml
set(:mongrel_conf) { "#{shared_path}/config/mongrel_cluster.yml" }