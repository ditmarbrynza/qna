# frozen_string_literal: true

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '65.21.61.45', user: 'deployer', roles: %w[app db web], primary: true
set :rails_env, :production
set :init_system, :systemd
set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }

set :ssh_options,
    keys: %w[/home/ditmar/.ssh/id_rsa],
    forward_agent: true,
    auth_methods: %w[publickey password],
    port: 2224
