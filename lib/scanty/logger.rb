module Scanty
  class Logger
    def self.create
      if Scanty::Base.settings.environment == 'production'
        ::Logger.new($stdout)
      else
        file = File.new("#{Scanty::Base.settings.root}/../log/#{Scanty::Base.settings.environment}.log", 'a+')
        file.sync = true
        ::Logger.new(file)
      end
    end

  end
end
