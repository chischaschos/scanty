source 'https://rubygems.org'
ruby '1.9.3'

gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'haml'
gem 'kramdown'
gem 'newrelic_rpm'
gem 'pg'
gem 'rake'
gem 'sass'
gem 'sequel'
gem 'sinatra'
gem 'shotgun'
gem "sprockets", "~> 2.10.1"
gem "syntax", "~> 1.0.0"
gem 'puma'

group :development, :test do
  gem 'foreman'
  gem 'pry-debugger'
  gem 'sqlite3'
  gem 'yui-compressor'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'simplecov', require: false

  # In order to save_and_open_page
  gem 'launchy'
  gem 'rspec'
end
