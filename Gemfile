source 'http://rubygems.org'

gem 'rails', '3.1.10'

#database
gem 'pg', '0.14.1', :require => 'pg'
gem 'activerecord-postgresql-adapter'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass'
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'

  gem 'uglifier', '>= 1.0.3'
end

# annotate models
gem 'annotate', ">= 2.5.0"

# frontend
gem 'bourbon'
gem 'haml'
gem "haml-rails"
gem 'jquery-rails'

# pagination
gem 'will_paginate', '~> 3.0.0'

#auth
gem 'devise'

#permissions
gem 'cancan'

gem 'newrelic_rpm'

group :development do
  #performance
  gem 'rack-mini-profiler'
  gem 'bullet'
end

group :development, :test do
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'letter_opener'
  gem 'pry-debugger'
  gem "rspec-rails"
  gem 'therubyracer'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '>= 0.6.7'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
end