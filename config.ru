$LOAD_PATH << File.expand_path('lib')

require 'scanty'

unless Scanty::WebApp.settings.environment == 'production'
  map '/assets' do
    run Scanty::Assets.environment Scanty::WebApp.root
  end
end

map '/' do
  run Scanty::WebApp
end
