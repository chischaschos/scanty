ENV['APP_ENV'] = 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler'
Bundler.require :default, :test

$LOAD_PATH << File.expand_path('lib')
require 'scanty'


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
require_relative 'factories'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  config.include FactoryGirl::Syntax::Methods

  config.around(:each) do |example|
    Scanty::Base.db.tables.each do |table|
      Scanty::Base.db[table].delete
    end

    example.run

    Scanty::Base.db.tables.each do |table|
      Scanty::Base.db[table].delete
    end
  end

  config.before(:suite) do
    FactoryGirl.lint
  end

end
