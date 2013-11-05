source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgres as the database for Active Record in production
group :production do
  gem 'pg'
end

# sqlite3 for development environments as well as rspec tools for legit testing
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :assets do
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
end

# Use SCSS for stylesheets
gem 'sass-rails', '>= 3.2'

# bootstrap
gem 'bootstrap-sass', '~> 3.0.1.0.rc'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# authentication tools
gem 'devise'

# for managing erb files better
gem 'slim'

# for managing roles and permissions
gem 'cancan'

# for markdown syntax and editing
gem 'redcarpet'

# for pagination
gem 'will_paginate'
gem 'will_paginate-bootstrap'

# for breadcrumbs
gem "breadcrumbs_on_rails"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
