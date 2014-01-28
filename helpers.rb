module Sinatra
  module Blogging
    module Helpers

      def admin?
        request.cookies[settings.blog.admin_cookie_key] == settings.blog.admin_cookie_value
      end

      def auth
        halt [ 401, 'Not authorized' ] unless admin?
      end

      def asset_path file
        if ENV['RACK_ENV'] == 'production'
          "/assets/#{settings.manifest.assets[file]}"
        else
          "/assets/#{file}"
        end
      end

    end
  end
end
