require 'ostruct'

ENV['APP_ENV'] ||= 'development'

module Scanty
  autoload :Assets,  'scanty/assets'
  autoload :Base,    'scanty/base'
  autoload :Helpers, 'scanty/helpers'
  autoload :Logger,  'scanty/logger'
  autoload :Post,    'scanty/post'
  autoload :WebApp,  'scanty/web_app'

  TITLE = 'chischaschos'
  AUTHOR = 'ed'

  extend self

  attr_accessor :db, :settings

  def setup
    raise "DATABASE_URL not set" unless ENV['DATABASE_URL']
    raise "BLOG_PASSWD not set" unless ENV['BLOG_PASSWD']
    raise "COOKIE_KEY not set" unless ENV['COOKIE_KEY']
    raise "COOKIE_VALUE not set" unless ENV['COOKIE_VALUE']
    raise "CARNIVAL_ID not set" unless ENV['CARNIVAL_ID']


    self.settings = OpenStruct.new title: 'chischaschos',
      author: 'ed',
      url_base: 'http://emmanueldelgado.me',
      admin_password: ENV['BLOG_PASSWD'],
      admin_cookie_key: ENV['COOKIE_KEY'],
      admin_cookie_value: ENV['COOKIE_VALUE'],
      carnival_id: ENV['CARNIVAL_ID']
  end
end
