require 'rubygems'
require 'bundler'

Bundler.require :default
Dotenv.load ".env.#{ENV['RACK_ENV'].downcase}", '.env'

module Scanty
  class Base < Sinatra::Base

    configure do
      Scanty.setup

      set :root, File.expand_path('app')
      set :sprockets, Scanty::Assets.environment(settings.root)
      set :manifest, Sprockets::Manifest.new(settings.sprockets, './public/assets')
      set :haml, format: :html5

    end

    layout 'layout'
  end
end
