require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler'
Bundler.require :default, :test

$LOAD_PATH << File.expand_path('lib')
require 'scanty'

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'capybara/rspec'

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  # Silently return an empty 200 response for any requests to unknown URLs.
  config.block_unknown_urls

  config.skip_image_loading
end

Capybara.app = Scanty::WebApp

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  config.after  do
    Scanty.db.tables.each do |table|
      Scanty.db[table].delete
    end
  end

end
