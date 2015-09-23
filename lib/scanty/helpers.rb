module Scanty
  module Helpers

    def admin?
      request.cookies[Scanty.settings.admin_cookie_key] == Scanty.settings.admin_cookie_value
    end

    def auth
      halt [ 401, 'Not authorized' ] unless admin?
    end

    def asset_path file
      if Scanty::WebApp.settings.environment == 'production'
        "/assets/#{Scanty::WebApp.settings.manifest.assets[file]}"
      else
        "/assets/#{file}"
      end
    end

  end
end
