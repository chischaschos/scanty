require 'rubygems'
require 'bundler'
Bundler.require :default, :test

$LOAD_PATH << File.expand_path('lib')
require 'scanty'

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'capybara/rspec'

Capybara.javascript_driver = :webkit
Capybara.app = Scanty::WebApp

RSpec.configure do |config|

  config.after  do
    Scanty.db.tables.each do |table|
      Scanty.db[table].delete
    end
  end

end
