module Sinatra
  module Blogging
    module Assets
      def self.environment root_path
        environment = Sprockets::Environment.new root_path
        environment.append_path 'bower_components/jquery'
        environment.append_path 'bower_components/modernizr'
        environment.append_path 'bower_components/foundation'
        environment.append_path 'assets/js'
        environment.append_path 'assets/css'
        environment
      end
    end
  end
end
