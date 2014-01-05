require 'rubygems'
require 'bundler'

Bundler.require :default

require_relative 'config'
require_relative 'helpers'
require_relative 'routes'

module Sinatra
  module Blogging
    class App < Sinatra::Base

      set :root, File.dirname(__FILE__)
      set :run, false
      set :env, ENV['RACK_ENV'] || 'development'

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
