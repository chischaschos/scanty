module Scanty
  module Assets
    def self.environment root_path
      environment = Sprockets::Environment.new root_path
      environment.append_path 'bower_components'
      environment.append_path 'assets/js'
      environment.append_path 'assets/css'
      environment
    end
  end
end
