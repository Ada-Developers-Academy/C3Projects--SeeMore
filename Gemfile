source 'https://rubygems.org'

gem 'dotenv-rails', :groups => [:development, :test]
# Auth
gem 'omniauth'
gem 'omniauth-instagram'
# reading APIs
gem 'httparty'
# Twitter API
gem 'twitter'
# Instagram API
gem 'instagram'
# styling
gem 'bootstrap-sass'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'webmock'
end

group :development, :test do
  # troubleshooting
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'

  #testing
  gem 'rspec-rails'
  gem 'simplecov', require: false
  gem 'factory_girl_rails', "~> 4.0"
  gem 'vcr'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # for inspecting route usage
  gem 'traceroute'
end

group :production do
    gem 'pg'
end
