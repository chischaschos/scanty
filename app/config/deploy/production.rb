server '104.131.140.58',
  user: 'deploy',
  roles: %w{app}

set :ssh_options, {
  forward_agent: true,
  keys: %w(/Users/emmanueldelgado/.ssh/larin.s931@gmail.com.identity)
}
