$LOAD_PATH << File.expand_path('lib')
require 'dotenv/tasks'
require 'rake/sprocketstask'
require 'yui/compressor'

ENV['RACK_ENV'] ||= 'development'
require 'scanty'

Rake::SprocketsTask.new do |t|
  environment = Scanty::Assets.environment Scanty::WebApp.root
  environment.css_compressor = YUI::CssCompressor.new
  environment.js_compressor = YUI::JavaScriptCompressor.new

  t.environment = environment
  t.output      = "app/public/assets"
  t.assets      = %w( application.js application.css )
end
