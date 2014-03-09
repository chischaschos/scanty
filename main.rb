require 'rubygems'
require 'bundler'

Bundler.require :default
Dotenv.load! ".env.#{ENV['RACK_ENV'].downcase}" unless ENV['NO_DOTENV']

require_relative 'config'
require_relative 'helpers'
require_relative 'routes'
require_relative 'assets'

module Sinatra
  module Blogging
    class App < Sinatra::Base

      set :root, File.realdirpath('.')
      set :run, false
      set :sprockets, Sinatra::Blogging::Assets.environment(settings.root)
      set :manifest, Sprockets::Manifest.new(settings.sprockets, './public/assets')

      register Sinatra::Blogging::Config
      helpers Sinatra::Blogging::Helpers
      register Sinatra::Blogging::Routes

      $LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
      require 'post'

      set :haml, format: :html5
      layout 'layout'

    end
  end
end
