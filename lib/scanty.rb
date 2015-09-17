require 'ostruct'

ENV['APP_ENV'] ||= 'development'

module Scanty
  autoload :Assets, 'scanty/assets'
  autoload :Base, 'scanty/base'
  autoload :Helpers, 'scanty/helpers'
  autoload :Post, 'scanty/post'
  autoload :WebApp, 'scanty/web_app'

  TITLE = 'chischaschos'
  AUTHOR = 'ed'

  extend self

  attr_accessor :db, :settings

  def setup
    raise "DATABASE_URL not set" unless ENV['DATABASE_URL']
    raise "BLOG_PASSWD not set" unless ENV['BLOG_PASSWD']
    raise "COOKIE_KEY not set" unless ENV['COOKIE_KEY']
    raise "COOKIE_VALUE not set" unless ENV['COOKIE_VALUE']
    raise "DISQUS_SHORTNAME not set" unless ENV['DISQUS_SHORTNAME']


    self.settings = OpenStruct.new title: 'chischaschos',
      author: 'ed',
      url_base: 'http://emmanueldelgado.me',
      admin_password: ENV['BLOG_PASSWD'],
      admin_cookie_key: ENV['COOKIE_KEY'],
      admin_cookie_value: ENV['COOKIE_VALUE'],
      disqus_shortname: ENV['DISQUS_SHORTNAME']
  end

  def db
    @db ||= Sequel.connect(ENV['DATABASE_URL'])
  end

end
