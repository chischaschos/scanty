require 'ostruct'

module Sinatra
  module Blogging

    module Config

      TITLE = 'chischaschos'
      AUTHOR = 'ed'

      def self.registered app
        app.configure do

          raise "DATABASE_URL not set" unless ENV['DATABASE_URL']
          raise "BLOG_PASSWD not set" unless ENV['BLOG_PASSWD']
          raise "COOKIE_KEY not set" unless ENV['COOKIE_KEY']
          raise "COOKIE_VALUE not set" unless ENV['COOKIE_VALUE']
          raise "DISQUS_SHORTNAME not set" unless ENV['DISQUS_SHORTNAME']

          app.set :db, Sequel.connect(ENV['DATABASE_URL'])

          app.set :blog, OpenStruct.new(
            title: 'chischaschos',
            author: 'ed',
            url_base: 'http://emmanueldelgado.me',
            admin_password: ENV['BLOG_PASSWD'],
            admin_cookie_key: ENV['COOKIE_KEY'],
            admin_cookie_value: ENV['COOKIE_VALUE'],
            disqus_shortname: ENV['DISQUS_SHORTNAME']
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
