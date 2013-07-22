source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem "pg", "~> 0.15.1"
gem 'will_paginate', '3.0.3'
gem 'slim-rails'
gem 'rename'
gem 'paperclip'
gem 'omniauth-facebook', '1.4.0'
gem 'bourbon'
gem 'newrelic_rpm'
# gem 'therubyracer' # uncomment if using vagrant

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'headless'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'passenger' # comment if Windows
  # gem 'wmd' # uncomment if Windows
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'faker'

  #guard!
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-spork'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'guard-bundler'
  gem 'guard-passenger' # comment if Windows and remove from Guardfile
  # gem 'guard-rails' # uncomment if Windows and add to Guardfile
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'