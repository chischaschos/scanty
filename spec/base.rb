require 'rubygems'
require 'bundler'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require './main'

Bundler.require :default, :test

require 'capybara/rspec'

Capybara.javascript_driver = :webkit
Capybara.app = Sinatra::Blogging::App


RSpec.configure do |config|

  config.after  do
    Sinatra::Blogging::App.settings.db.tables.each do |table|
      Sinatra::Blogging::App.settings.db[table].delete
    end
  end

end
