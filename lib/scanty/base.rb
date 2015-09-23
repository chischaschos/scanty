require 'rubygems'
require 'bundler'

Bundler.require :default
Dotenv.load ".env.#{ENV['APP_ENV'].downcase}", '.env'

module Scanty
  class Base < Sinatra::Base

    configure do
      Scanty.setup

      set :environment, ENV['APP_ENV']
      set :root,        File.expand_path('app')
      set :logger,      Scanty::Logger.create
      set :db,          Sequel.connect(ENV['DATABASE_URL'], loggers: [ settings.logger ])
      set :sprockets,   Scanty::Assets.environment(settings.root)
      set :manifest,    Sprockets::Manifest.new(settings.sprockets, settings.root + '/public/assets')
      set :haml,        format: :html5

      enable :logging

      use Rack::CommonLogger,  settings.logger
    end

    layout 'layout'
  end
end
