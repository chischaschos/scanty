server ENV['PROD_SERVER'],
  user: 'deploy',
  roles: %w{app}

set :ssh_options, {
  forward_agent: true,
  keys: ENV['DEPLOY_KEY_FILE']
}
