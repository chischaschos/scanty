require 'main'

set :run, false
set :env, ENV['RACK_ENV']

run Sinatra::Application
