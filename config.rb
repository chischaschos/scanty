require 'ostruct'

module Sinatra
  module Blogging

    module Config

      def self.registered app
        app.configure :production do

          raise "DATABASE_URL not set" unless ENV['DATABASE_URL']
          raise "BLOG_PASSWD not set" unless ENV['BLOG_PASSWD']
          raise "COOKIE_KEY not set" unless ENV['COOKIE_KEY']
          raise "COOKIE_VALUE not set" unless ENV['COOKIE_VALUE']
          raise "DISQUS_SHORTNAME not set" unless ENV['DISQUS_SHORTNAME']

          app.set :db, Sequel.connect(ENV['DATABASE_URL'])

          set :blog, OpenStruct.new(
            :title => "Emmanuel Delgado's blog",
            :author => 'Emmanuel Delgado',
            :url_base => 'http://emmanueldelgado.me',
            :admin_password => ENV['BLOG_PASSWD'],
            :admin_cookie_key => ENV['COOKIE_KEY'],
            :admin_cookie_value => ENV['COOKIE_VALUE'],
            :disqus_shortname => ENV['DISQUS_SHORTNAME']
          )
        end

        app.configure :development do
          app.set :db, Sequel.connect('sqlite://blog.db')

          app.set :blog, OpenStruct.new(
            :title => "Emmanuel Delgado's blog",
            :author => 'Emmanuel Delgado',
            :url_base => 'http://localhost/',
            :admin_password => '123',
            :admin_cookie_key => '123',
            :admin_cookie_value => '123',
            :disqus_shortname => '123'
          )
        end

        app.configure :test do
          app.set :db, Sequel.sqlite

          app.set :blog, OpenStruct.new(
            :title => "Emmanuel Delgado's blog",
            :author => 'Emmanuel Delgado',
            :url_base => 'http://localhost/',
            :admin_password => '123',
            :admin_cookie_key => '123',
            :admin_cookie_value => '123',
            :disqus_shortname => '123'
          )
        end

        app.error do
          e = request.env['sinatra.error']
          puts e.to_s
          puts e.backtrace.join("\n")
          "Application error"
        end

      end
    end
  end
end
