configure :production do

  raise "DATABASE_URL not set" unless ENV['DATABASE_URL']
  raise "BLOG_PASSWD not set" unless ENV['BLOG_PASSWD']
  raise "COOKIE_KEY not set" unless ENV['COOKIE_KEY']
  raise "COOKIE_VALUE not set" unless ENV['COOKIE_VALUE']
  raise "DISQUS_SHORTNAME not set" unless ENV['DISQUS_SHORTNAME']

  DB = Sequel.connect ENV['DATABASE_URL']

  require 'ostruct'
  Blog = OpenStruct.new(
    :title => "Emmanuel Delgado's blog",
    :author => 'Emmanuel Delgado',
    :url_base => 'http://emmanueldelgado.me',
    :admin_password => ENV['BLOG_PASSWD'],
    :admin_cookie_key => ENV['COOKIE_KEY'],
    :admin_cookie_value => ENV['COOKIE_VALUE'],
    :disqus_shortname => ENV['DISQUS_SHORTNAME']
  )
end

configure :test, :development do
  DB = Sequel.connect 'sqlite://blog.db'

  require 'ostruct'
  Blog = OpenStruct.new(
    :title => "Emmanuel Delgado's blog",
    :author => 'Emmanuel Delgado',
    :url_base => 'http://localhost/',
    :admin_password => 123,
    :admin_cookie_key => 123,
    :admin_cookie_value => 123,
    :disqus_shortname => 123
  )
end
