$LOAD_PATH << File.expand_path('lib')

require 'scanty'

unless ENV['RACK_ENV'] == 'production'
  map '/assets' do
    run Scanty::Assets.environment Scanty::WebApp.root
  end
end

map '/' do
  run Scanty::WebApp
end
