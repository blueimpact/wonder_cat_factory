source 'https://rubygems.org'

ruby '2.2.3'
gem 'rails', '4.2.4'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'unicorn'
gem 'foreman'
gem 'slim-rails'
gem 'kaminari'
gem 'settingslogic'
gem 'devise'

gem 'bootstrap-sass'
gem 'font-awesome-rails'

gem 'rails-i18n'

gem 'pry-rails'
gem 'awesome_print'

group :development, :test do
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'tapp'
  gem 'quiet_assets'

  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-livereload', require: false
  gem 'factory_girl_rails'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails-footnotes'
end

group :test do
  gem 'timecop'
  gem 'fuubar'
  gem 'webmock'
  gem 'simplecov', require: false
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end