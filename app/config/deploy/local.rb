server '127.0.0.1',
  user: 'deploy',
  roles: %w{app}

set :ssh_options, {
  forward_agent: true,
  port: 2222,
  #keys: %w(/some/place/private_key),
}
