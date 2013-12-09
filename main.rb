require 'rubygems'
require 'bundler'

Bundler.require :default

require_relative 'config'
require_relative 'assets'
require_relative 'helpers'
require_relative 'routes'

module Sinatra
  module Blogging
    class App < Sinatra::Base

      set :root, File.dirname(__FILE__)

      register Sinatra::Blogging::Config
      register Sinatra::Blogging::Assets
      helpers Sinatra::Blogging::Helpers
      register Sinatra::Blogging::Routes

      $LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
      require 'post'

      set :haml, format: :html5
      layout 'layout'

    end
  end
end
