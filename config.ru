require './main'

unless ENV['RACK_ENV'] == 'production'
  map '/assets' do
    run Sinatra::Blogging::Assets.environment Sinatra::Blogging::App.root
  end
end

map '/' do
  run Sinatra::Blogging::App
end
