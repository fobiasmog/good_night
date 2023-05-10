source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "will_paginate", "~> 3.3"

group :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 5.0'
end
