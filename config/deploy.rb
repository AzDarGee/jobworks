set :application, "jobworks"
set :repo_url, "git@github.com:AzDarGee/jobworks.git"

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads', 'public/packs', 'node_modules', 'storage'
set :linked_files, %w{config/master.key config/credentials/production.key}
set :ssh_options, { forward_agent: true, keys: "~/.ssh/id_rsa" }

set :default_env, {
  PATH: '$HOME/.npm-packages/bin/:$PATH',
  NODE_ENVIRONMENT: 'production'
}
set :website_url,     'jobworks.lucidlabs.studio'
set :enable_ssl,      true
set :ssl_certificate, '/etc/letsencrypt/live/jobworks.lucidlabs.studio/fullchain.pem'
set :ssl_key,         '/etc/letsencrypt'

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
set :rails_assets_groups, :assets

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
set :normalize_asset_timestamps, %w{public/packs public/assets}
set :assets_roles, [:web, :app]

# Only keep the last 5 releases to save disk space
set :keep_releases, 5
set :passenger_restart_with_touch, true

# Optionally, you can symlink your database.yml and/or secrets.yml file from the shared directory during deploy
# This is useful if you don't want to use ENV variables
# append :linked_files, 'config/database.yml', 'config/secrets.yml'