require 'rubygems'
require 'bundler'

Bundler.require :default, :test

ENV['RACK_ENV'] = 'test'

require './config'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'post'
