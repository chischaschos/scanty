module Sinatra
  module Blogging
    module Helpers

      def admin?
        request.cookies[settings.blog.admin_cookie_key] == settings.blog.admin_cookie_value
      end

      def auth
        halt [ 401, 'Not authorized' ] unless admin?
      end

    end
  end
end
