require 'rubygems'
require 'bundler'

Bundler.require :default
Dotenv.load ".env.#{ENV['RACK_ENV'].downcase}", '.env'

module Scanty
  class WebApp < Sinatra::Base

    configure do
      Scanty.setup
    end

    set :root, File.expand_path('.')
    set :run, false
    set :sprockets, Scanty::Assets.environment(settings.root)
    set :manifest, Sprockets::Manifest.new(settings.sprockets, './public/assets')
    set :haml, format: :html5

    layout 'layout'

    use Scanty::Routes
  end
end
