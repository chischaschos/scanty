module Sinatra
  module Blogging
    module Assets

      def self.registered app
        app.register Sinatra::AssetPack

        app.assets do
          serve '/js', :from => 'assets/js'

          js :foundation, [
            '/js/foundation/foundation.js',
            '/js/foundation/foundation.*.js'
          ]

          js :application, [
            '/js/vendor/*.js',
            '/js/app.js'
          ]

          serve '/css', :from => 'assets/stylesheets'
          css :application, [
            '/css/normalize.css',
            '/css/app.css'
          ]

          js_compression :jsmin
          css_compression :sass
        end
      end
    end
  end
end
