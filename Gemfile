# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

group :development, :test do
  # Debugging tool
  gem 'pry-rails'
  gem 'rubocop', '1.25.1'
  gem 'rubocop-rails', '2.13.2'
  gem 'rubocop-rspec', '2.8.0'
  # Tests
  gem 'bullet'
  gem 'capybara', '~> 2.7', '>= 2.7.1'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
