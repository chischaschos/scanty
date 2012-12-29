require 'rubygems'
require 'bundler'

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

ENV['RACK_ENV'] = 'test'

require './main'
Bundler.require :default, :test

require 'capybara/rspec'

Capybara.javascript_driver = :webkit
Capybara.app = Sinatra::Application.new
