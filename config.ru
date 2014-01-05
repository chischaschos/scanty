require './main'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'bower_components/jquery'
  environment.append_path 'bower_components/modernizr'
  environment.append_path 'bower_components/foundation'
  environment.append_path 'assets'
  run environment
end

map '/' do
  run Sinatra::Blogging::App
end
