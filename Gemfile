source 'https://rubygems.org'

gem 'rails', '4.0.2'

gem 'awesome_print'
gem 'cancan'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'
gem 'jbuilder', '~> 1.2'
gem 'jquery-rails'
gem 'prawn'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'activeadmin', github: 'gregbell/active_admin'

#group :assets do
  gem 'angularjs-rails'
  gem 'slim-rails'
#end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov'
  gem 'poltergeist'
  gem 'pdf-inspector'
end

group :development, :test do
  gem 'sqlite3'
  gem 'zeus'
  gem 'rspec-rails', '~> 2.0'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'faker', "~> 1.2.0" 
  gem 'quiet_assets'
  gem 'capybara-angular'
end

group :production, :staging do
  gem 'therubyracer'
  gem 'pg'
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
