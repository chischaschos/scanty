require './main'

set :run, false
set :env, ENV['RACK_ENV'] || 'development'

run Sinatra::Blogging::App
