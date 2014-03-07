require_relative 'main'
require 'dotenv/tasks'
require 'rake/sprocketstask'
require 'yui/compressor'

Rake::SprocketsTask.new do |t|
  environment = Sinatra::Blogging::Assets.environment Sinatra::Blogging::App.root
  environment.css_compressor = YUI::CssCompressor.new
  environment.js_compressor = YUI::JavaScriptCompressor.new

  t.environment = environment
  t.output      = "./public/assets"
  t.assets      = %w( application.js modernizr.js application.css )
end
