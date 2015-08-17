$LOAD_PATH << File.expand_path('lib')

require 'scanty'

unless Scanty::WebApp.settings.env == 'production'
  map '/assets' do
    run Scanty::Assets.environment Scanty::WebApp.root
  end
end

map '/' do
  run Scanty::WebApp
end
